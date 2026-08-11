<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>쌍용축구예약프로그램</title>
    <link rel="icon" href="data:;base64,iVBORw0KGgo=" />
    
    <!-- 1. 공통 헤더 리소스(CSS, CDN 등) 조립 -->
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
</head>
<body>

    <!-- 2. 공통 상단 네비게이션/헤더 조립 -->
    <jsp:include page="/WEB-INF/views/layout/header.jsp" />

    <!-- 3. 메인 페이지 본문 영역 -->
    <!-- 메인 배너 Carousel -->
    <div class="container mt-3">
        <div id="banner-placeholder">
            <div id="carouselExampleFade" class="carousel slide carousel-fade" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img src="${pageContext.request.contextPath}/dist/images/bg_1.png" class="d-block w-100" alt="메인배너 1" />
                    </div>
                    <div class="carousel-item">
                        <img src="${pageContext.request.contextPath}/dist/images/bg_2.jpg" class="d-block w-100" alt="메인배너 2" />
                    </div>
                    <div class="carousel-item">
                        <img src="${pageContext.request.contextPath}/dist/images/bg_3.jpg" class="d-block w-100" alt="메인배너 3" />
                    </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </div>
    </div>

    <!-- 메인 검색 필터 바 -->
    <div class="search-filter-section">
        <div class="search-card">
            <form class="row g-2 align-items-end" onsubmit="return false;">
                <div class="col-md-3">
                    <label class="form-label small text-muted mb-1 fw-bold"><i class="bi bi-calendar3 me-1"></i>경기 날짜</label>
                    <input type="date" class="form-control form-control-sm" value="2026-08-01">
                </div>
                <div class="col-md-3">
                    <label class="form-label small text-muted mb-1 fw-bold"><i class="bi bi-geo-alt me-1"></i>지역 / 경기장</label>
                    <select class="form-select form-select-sm">
                        <option value="">전체 경기장</option>
                        <option value="1">쌍용축구경기장 (마포)</option>
                        <option value="2">마포구민체육센터</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label small text-muted mb-1 fw-bold"><i class="bi bi-people me-1"></i>매칭 종류</label>
                    <select class="form-select form-select-sm">
                        <option value="">전체 매칭</option>
                        <option value="11">11 vs 11 축구</option>
                        <option value="6">6 vs 6 풋살</option>
                    </select>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button type="button" class="btn btn-primary btn-sm w-100 fw-bold py-2 mt-auto" style="background-color: #6b4ba1; border:none;">
                        <i class="bi bi-search me-1"></i> 매치 검색하기
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- 실시간/다가오는 매치 목록 영역 -->
    <div class="container match_section_wrapper">
        <div class="d-flex justify-content-between align-items-center">
            <h5 class="fw-bold mb-0"><i class="bi bi-fire text-danger me-1"></i> 마감 임박 매치 목록</h5>
            <a href="#" class="text-decoration-none small text-muted fw-bold">전체 경기 일정 보기 ></a>
        </div>

        <div class="match_section">
            <div class="match_box">
                <div class="match_date">2026-08-01 (토)</div>
                <div class="match_inner_box">
                    <div class="team">A팀</div>
                    <span class="vs-text">VS</span>
                    <div class="team">B팀</div>
                </div>
                <div class="stadium-name">쌍용축구경기장</div>
                <div class="match-time"><i class="bi bi-clock me-1"></i>19:30</div>
                <button class="btn btn-sm btn-outline-primary w-100 mt-2" style="font-size: 11px;">신청 가능</button>
            </div>

            <div class="match_box">
                <div class="match_date">2026-08-01 (토)</div>
                <div class="match_inner_box">
                    <div class="team">FC쌍용</div>
                    <span class="vs-text">VS</span>
                    <div class="team">드림FC</div>
                </div>
                <div class="stadium-name">쌍용축구경기장</div>
                <div class="match-time"><i class="bi bi-clock me-1"></i>20:30</div>
                <button class="btn btn-sm btn-outline-primary w-100 mt-2" style="font-size: 11px;">신청 가능</button>
            </div>

            <div class="match_box">
                <div class="match_date">2026-08-02 (일)</div>
                <div class="match_inner_box">
                    <div class="team">C팀</div>
                    <span class="vs-text">VS</span>
                    <div class="team">D팀</div>
                </div>
                <div class="stadium-name">마포구민센터</div>
                <div class="match-time"><i class="bi bi-clock me-1"></i>18:00</div>
                <button class="btn btn-sm btn-secondary w-100 mt-2 disabled" style="font-size: 11px;">마감 완료</button>
            </div>

            <div class="match_box">
                <div class="match_date">2026-08-02 (일)</div>
                <div class="match_inner_box">
                    <div class="team">E팀</div>
                    <span class="vs-text">VS</span>
                    <div class="team">F팀</div>
                </div>
                <div class="stadium-name">쌍용축구경기장</div>
                <div class="match-time"><i class="bi bi-clock me-1"></i>21:00</div>
                <button class="btn btn-sm btn-outline-primary w-100 mt-2" style="font-size: 11px;">신청 가능</button>
            </div>
        </div>
    </div>

    <!-- 4. 공통 푸터 조립 -->
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />

</body>
</html>