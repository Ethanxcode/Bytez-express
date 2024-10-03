// cron.ts
import schedule from 'node-schedule';
import { Request, Response } from 'express';

// Hàm để đo performance (giả lập)
const measurePerformance = (jobName: string) => {
  const now = new Date();
  console.log(`Job ${jobName} is running at ${now.toISOString()}`);
};

const scheduleJobs = () => {
  for (let i = 1; i <= 10000; i++) { 
    const jobName = `Job ${i}`;

    // Lập lịch cho mỗi job chạy mỗi phút
    schedule.scheduleJob(`*/1 * * * *`, () => measurePerformance(jobName));

    console.log(`Scheduled ${jobName}`);
  }
};

export default scheduleJobs;
