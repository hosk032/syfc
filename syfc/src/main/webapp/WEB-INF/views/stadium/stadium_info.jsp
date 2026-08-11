<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>경기장 정보 검색 - 쌍용축구예약</title>

    <!-- 1. 공통 CSS/CDN/폰트 리소스 조립 -->
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

    <!-- API 키가 필요없는 오픈소스 무료 지도 (Leaflet.js) -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

    <!-- 2. 경기장 정보 전용 CSS 연결 (dist/css/community/stadium.css) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/community/stadium.css" />
</head>
<body>

    <!-- 상단 헤더/네비게이션 조립 -->
    <jsp:include page="/WEB-INF/views/layout/header.jsp" />

    <!-- 3. 경기장 검색 필터 바 -->
    <div class="search-filter-section my-4">
        <div class="search-card">
            <h5 class="fw-bold mb-3" style="color: #6b4ba1;"><i class="bi bi-search me-2"></i>경기장 위치 검색</h5>
            <form class="row g-3 align-items-end" onsubmit="return false;">
                <!-- 지역 선택 -->
                <div class="col-md-5">
                    <label class="form-label small text-muted fw-bold"><i class="bi bi-geo-alt me-1"></i>지역 선택</label>
                    <select id="regionSelect" class="form-select custom-input" onchange="updateStadiumOptions()">
                        <option value="all">전국 전체</option>
                        <option value="seoul" selected>서울특별시</option>
                        <option value="gyeonggi">경기도</option>
                        <option value="incheon">인천광역시</option>
                        <option value="busan">부산광역시</option>
                        <option value="daegu">대구광역시</option>
                        <option value="gwangju">광주광역시</option>
                        <option value="daejeon">대전광역시</option>
                        <option value="gangwon">강원특별자치도</option>
                    </select>
                </div>

                <!-- 경기장 선택 -->
                <div class="col-md-5">
                    <label class="form-label small text-muted fw-bold"><i class="bi bi-building me-1"></i>경기장 선택</label>
                    <select id="stadiumSelect" class="form-select custom-input">
                        <!-- 스크립트에서 자동 생성됩니다 -->
                    </select>
                </div>

                <!-- 검색 버튼 -->
                <div class="col-md-2">
                    <button type="button" class="btn btn-login-submit w-100 fw-bold py-2" onclick="searchStadium()">
                        조회하기
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- 4. 지도 및 상세 정보 조회 영역 -->
    <div class="stadium-detail-section mb-5">
        <div class="row g-4">
            <!-- 좌측: 지도 표시 영역 -->
            <div class="col-lg-7">
                <div id="map-container">
                    <div id="map"></div>
                </div>
            </div>

            <!-- 우측: 경기장 상세 정보 표 및 예약 상태 -->
            <div class="col-lg-5">
                <div class="info-card d-flex flex-column justify-content-between">
                    <div>
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 id="displayStadiumName" class="fw-bold mb-0">쌍용축구경기장 (마포)</h4>
                            <span id="displayStatus" class="status-badge status-available">예약가능</span>
                        </div>
                        <p id="displayRegionTag" class="text-muted small mb-3"><i class="bi bi-tag me-1"></i>서울 마포구</p>
                        
                        <table class="info-table w-100">
                            <tbody>
                                <tr>
                                    <th><i class="bi bi-geo-alt me-1"></i>주소</th>
                                    <td id="displayAddress">서울특별시 마포구 월드컵로 240</td>
                                </tr>
                                <tr>
                                    <th><i class="bi bi-map me-1"></i>지역</th>
                                    <td id="displayRegion">서울특별시 마포구</td>
                                </tr>
                                <tr>
                                    <th><i class="bi bi-people me-1"></i>수용인원</th>
                                    <td id="displayCapacity">정규 11 vs 11 (최대 500명 수용)</td>
                                </tr>
                                <tr>
                                    <th><i class="bi bi-info-circle me-1"></i>부대시설</th>
                                    <td id="displayFacilities">야간 조명, 전용 주차장, 샤워실, 음료 자판기</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <!-- 예약하기 버튼 -->
                    <div class="mt-4">
                        <button id="bookingBtn" class="btn btn-login-submit w-100 py-3 fw-bold">
                            이 경기장 예약하기
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 하단 푸터 조립 -->
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />

    <!-- 5. 경기장 정보 전용 JS 연결 (dist/js/community/stadium_info.js) -->
    <script src="${pageContext.request.contextPath}/dist/js/community/stadium_info.js"></script>
</body>
</html>