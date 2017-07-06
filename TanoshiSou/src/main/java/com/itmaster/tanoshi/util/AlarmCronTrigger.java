package com.itmaster.tanoshi.util;

import java.text.ParseException;

import org.quartz.Job;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SchedulerFactory;
import org.quartz.impl.triggers.CronTriggerImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class AlarmCronTrigger implements Job {
	
	Logger log = LoggerFactory.getLogger(AlarmCronTrigger.class);
	
	Scheduler scheduler;
	
	private String time = "0/5 24-25 23 * * ? 3000";
	private String name = "myName";
	private String group = "events";
	
	private String u_email; // 받는 메일
	private String title; // 제목
	private String message; // 내용
	
	public AlarmCronTrigger() {}
	
	public AlarmCronTrigger(String time, String name, String u_email, String title, String message) {
		this.time = time;
		this.name = name;
		this.u_email = u_email;
		this.title = title;
		this.message = message;
		
		SchedulerFactory schedFact = new org.quartz.impl.StdSchedulerFactory();
		try {
			scheduler = schedFact.getScheduler();
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
	}
	
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getU_email() {
		return u_email;
	}
	public void setU_email(String u_email) {
		this.u_email = u_email;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
	public void createJob() {
		log.debug("createJob \n group: {}, name: {}, time: {}", group, name, time);
		log.debug("mail: {}, title: {}, message: {}", u_email, title, message);
        try {
            JobDetail details = JobBuilder.newJob(AlarmCronTrigger.class)
                    .withDescription("something")
                    .withIdentity(name, group)
                    .storeDurably(true).build();
            
            details.getJobDataMap().put("email", u_email);
            details.getJobDataMap().put("title", title);
            details.getJobDataMap().put("message", message);

            CronTriggerImpl trigger = new CronTriggerImpl();
            trigger.setName("EVENTS_ALARM" + name);

            try {
                trigger.setCronExpression(time);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            trigger.setDescription("desc");
            scheduler.scheduleJob(details,trigger);
            scheduler.start();
            log.debug("job started");
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
	}
	
	public void deleteJob() {
		log.debug("deleteJob \n group: {}, name: {}", group, name);
		try {
			scheduler.deleteJob(JobKey.jobKey(name, group));
			log.debug("job deleted");
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		String email = context.getMergedJobDataMap().get("email").toString();
		String title = context.getMergedJobDataMap().get("title").toString();
		String message = context.getMergedJobDataMap().get("message").toString();
		log.debug("mail: {}, title: {}, message: {}", email, title, message);
		new SendMail(email, title, message);
	}
}
