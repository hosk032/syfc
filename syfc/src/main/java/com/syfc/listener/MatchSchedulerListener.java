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

    @Override
    public void contextInitialized(ServletContextEvent sce) {

        System.out.println("====================================");
        System.out.println("경기 자동취소 스케줄러 시작");
        System.out.println("====================================");

        // mapper null이 일어나서 서버시작하고 5초 후 실행하게 바꿈
        scheduler = Executors.newSingleThreadScheduledExecutor();

        scheduler.schedule(
            () -> cancelExpiredMatches(),
            5,
            TimeUnit.SECONDS
        );

        // 이후 매일 자정에 실행
        scheduleNextMidnight();
    }

    // 경기 자동 취소 실행
    private void cancelExpiredMatches() {

        try {
            System.out.println();
            System.out.println("====================================");
            System.out.println("[경기 자동취소] 검사 시작");
            System.out.println("실행시간 : " + LocalDateTime.now());
            System.out.println("====================================");

            //Listener 객체가 생성될 때 Service를 만들지 않는다.
            // MapperContainer 초기화 이후에 생성하기 위해 여기서 service 만듬.
            MatchService service = new MatchServiceImpl();

            int count = service.cancelExpiredWaitingMatches();

            System.out.println("[경기 자동취소] 처리 완료 : " + count + "건");

        } catch (Exception e) {
            System.out.println("[경기 자동취소] 오류 발생");
            e.printStackTrace();
        }
    }

    // 다음 자정에 실행되도록 예약
    private void scheduleNextMidnight() {

        LocalDateTime now = LocalDateTime.now();

        LocalDateTime nextMidnight = LocalDateTime.of(
                    now.toLocalDate().plusDays(1), LocalTime.MIDNIGHT);

        long delayMillis = Duration.between(now, nextMidnight).toMillis();

        System.out.println("다음 자동취소 실행시간 : " + nextMidnight);

        scheduler.schedule( () -> {
                try {
                    cancelExpiredMatches();
                } finally {
                    // 다시 다음날 자정 예약
                    scheduleNextMidnight();
                }
            },
            delayMillis,
            TimeUnit.MILLISECONDS
        );
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("====================================");
        System.out.println("경기 자동취소 스케줄러 종료");
        System.out.println("====================================");

        if (scheduler != null) {
            scheduler.shutdownNow();
        }
    }
}