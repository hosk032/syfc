package com.syfc.listener;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import com.syfc.service.MatchService;
import com.syfc.service.MatchServiceImpl;

@WebListener
public class MatchSchedulerListener implements ServletContextListener {

    private ScheduledExecutorService scheduler;
    private MatchService service;

    @Override
    public void contextInitialized(ServletContextEvent sce) {

        System.out.println("====================================");
        System.out.println("경기 자동취소 스케줄러 시작");
        System.out.println("====================================");

        service = new MatchServiceImpl();

        //  ① 서버 시작 즉시 한 번 실행
        cancelExpiredMatches();

        // ② 매일 자정 실행
        scheduler = Executors.newSingleThreadScheduledExecutor();

        LocalDateTime now = LocalDateTime.now();

        LocalDateTime nextMidnight =
                LocalDateTime.of( now.toLocalDate().plusDays(1), LocalTime.MIDNIGHT);

        long initialDelay = Duration.between(now, nextMidnight).toMillis();
        long oneDay = TimeUnit.DAYS.toMillis(1);

        scheduler.scheduleAtFixedRate(this::cancelExpiredMatches,
                initialDelay,oneDay, TimeUnit.MILLISECONDS);

        System.out.println("다음 자동취소 실행시간 : " + nextMidnight);
    }

    // 경기일이 지난 미매칭 경기 자동 취소
    private void cancelExpiredMatches() {

        try {
            int count = service.cancelExpiredWaitingMatches();
            System.out.println( "[경기 자동취소] " + count + "건 처리 완료");

        } catch (Exception e) {

            System.err.println( "[경기 자동취소] 오류 발생");

            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

        System.out.println( "경기 자동취소 스케줄러 종료");

        if (scheduler != null) {
            scheduler.shutdown();
        }
    }
}