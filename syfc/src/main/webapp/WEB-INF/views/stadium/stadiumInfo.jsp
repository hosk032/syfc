<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>경기장 정보 검색 - 쌍용축구예약</title>

    <!-- 공통 리소스 -->
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

    <!-- Leaflet.js 지도 라이브러리 (CSS & JS 필수) -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

    <style>
        /* 1024px 고정 레이아웃 */
        .stadium-page-container {
            width: 100%;
            max-width: 1024px;
            margin: 0 auto;
            padding: 0 15px;
            box-sizing: border-box;
        }

        /* Card Layout */
        .custom-card {
            background: #ffffff;
            border: 1px solid #e9ecef;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
            box-sizing: border-box;
        }

        /* 지도 영역 크기 강제 고정 */
        #map-wrapper {
            width: 100%;
            height: 400px;
            min-height: 400px;
            border-radius: 12px;
            border: 1px solid #dee2e6;
            overflow: hidden;
            position: relative;
        }

        #map {
            width: 100% !important;
            height: 100% !important;
            min-height: 400px !important;
            z-index: 1;
        }

        /* 테이블 */
        .info-table {
            width: 100%;
            border-collapse: collapse;
        }

        .info-table th {
            width: 30%;
            color: #6c757d;
            font-weight: 600;
            font-size: 14px;
            padding: 10px 0;
            border-bottom: 1px solid #f1f3f5;
            text-align: left;
        }

        .info-table td {
            width: 70%;
            color: #212529;
            font-weight: 500;
            font-size: 14px;
            padding: 10px 0;
            border-bottom: 1px solid #f1f3f5;
        }

        /* 상태 배지 */
        .badge-status {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
        }
        .badge-available { background-color: #e6f4ea; color: #137333; }
        .badge-unavailable { background-color: #fce8e6; color: #c5221f; }

        /* Purple Button */
        .btn-purple {
            background-color: #6b4ba1;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            transition: background 0.2s;
        }
        .btn-purple:hover {
            background-color: #553a83;
            color: #ffffff;
        }
    </style>
</head>
<body>

    <!-- 헤더 -->
    <jsp:include page="/WEB-INF/views/layout/header.jsp" />

    <!-- 메인 컨테이너 -->
    <div class="stadium-page-container my-4">
        
        <!-- 1. 검색 영역 -->
        <div class="custom-card mb-4">
            <h5 class="fw-bold mb-3" style="color: #6b4ba1;"><i class="bi bi-search me-2"></i>경기장 위치 검색</h5>
            
            <form id="stadiumSearchForm" class="row g-3 align-items-end" action="${pageContext.request.contextPath}/stadium/stadiumInfo" method="get">
                <div class="col-md-3">
                    <label class="form-label small text-muted fw-bold mb-1"><i class="bi bi-filter me-1"></i>검색 구분</label>
                    <select id="schType" name="schType" class="form-select">
                        <option value="stadiumName" ${schType == 'stadiumName' ? 'selected' : ''}>경기장 이름</option>
                        <option value="region" ${schType == 'region' ? 'selected' : ''}>지역</option>
                    </select>
                </div>

                <div class="col-md-4">
                    <label class="form-label small text-muted fw-bold mb-1"><i class="bi bi-geo-alt me-1"></i>검색어</label>
                    
                    <input type="text" id="stadiumNameKeyword" class="form-control"
                        value="${schType == 'stadiumName' ? kwd : ''}" placeholder="경기장 이름을 입력하세요">
                    <select id="regionKeyword" class="form-select" style="display:none;">
                        <option value="">지역 선택</option>
                        <option value="서울시" ${schType == 'region' && kwd == '서울시' ? 'selected' : ''}>서울시</option>
                        <option value="경기도" ${schType == 'region' && kwd == '경기도' ? 'selected' : ''}>경기도</option>
                        <option value="인천시" ${schType == 'region' && kwd == '인천시' ? 'selected' : ''}>인천시</option>
                        <option value="안산시" ${schType == 'region' && kwd == '안산시' ? 'selected' : ''}>안산시</option>
                        <option value="수원시" ${schType == 'region' && kwd == '수원시' ? 'selected' : ''}>수원시</option>
                        <option value="성남시" ${schType == 'region' && kwd == '성남시' ? 'selected' : ''}>성남시</option>
                    </select>

                    <input type="hidden" id="kwd" name="kwd" value="${kwd}">
                </div>

                <div class="col-md-2">
                    <button type="submit" class="btn btn-purple w-100 py-2">검색하기</button>
                </div>

                <div class="col-md-3">
                    <label class="form-label small text-muted fw-bold mb-1"><i class="bi bi-building me-1"></i>경기장 선택</label>
                    <select id="stadiumSelect" class="form-select" onchange="changeStadium(this.value)">
                        <c:choose>
                            <c:when test="${not empty stadiumList}">
                                <c:forEach var="dto" items="${stadiumList}">
                                    <option value="${dto.stadiumId}">${dto.stadiumName} [${dto.region}]</option>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <option value="">검색 결과가 없습니다</option>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </div>
            </form>
        </div>

        <!-- 2. 지도 및 정보 표시 영역 -->
        <div class="row g-3 mb-4">
            <!-- 좌측: 지도 -->
            <div class="col-lg-7">
                <div id="map-wrapper">
                    <div id="map"></div>
                </div>
            </div>

            <!-- 우측: 정보 표 -->
            <div class="col-lg-5">
                <div class="custom-card h-100 d-flex flex-column justify-content-between">
                    <div>
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h4 id="displayStadiumName" class="fw-bold fs-5 mb-0">경기장을 선택해주세요</h4>
                            <span id="displayStatus" class="badge-status badge-unavailable">-</span>
                        </div>
                        <p id="displayRegionTag" class="text-muted small mb-3"><i class="bi bi-tag me-1"></i>-</p>
                        
                        <table class="info-table">
                            <tbody>
                                <tr>
                                    <th><i class="bi bi-geo-alt me-1"></i>주소</th>
                                    <td id="displayAddress">-</td>
                                </tr>
                                <tr>
                                    <th><i class="bi bi-map me-1"></i>지역</th>
                                    <td id="displayRegion">-</td>
                                </tr>
                                <tr>
                                    <th><i class="bi bi-people me-1"></i>수용인원</th>
                                    <td id="displayCapacity">-</td>
                                </tr>
                                <tr>
                                    <th><i class="bi bi-cash me-1"></i>대관료</th>
                                    <td id="displayCost">-</td>
                                </tr>
                                <tr>
                                    <th><i class="bi bi-info-circle me-1"></i>부대시설</th>
                                    <td id="displayFacilities">주차장, 야간조명 (상세문의)</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="mt-4">
                        <button id="bookingBtn" class="btn btn-purple w-100 py-2 fs-6" onclick="goBooking()">
                            이 경기장 예약하기
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 3. 페이징 -->
        <div class="pagingArea d-flex justify-content-center my-4">
            ${dataCount == 0 ? "등록된 경기장이 없습니다." : paging}
        </div>
    </div>

    <!-- 푸터 -->
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />

    <!-- JavaScript -->
    <script>
        const stadiumData = [
            <c:forEach var="dto" items="${stadiumList}" varStatus="status">
            {
                stadiumId: ${dto.stadiumId},
                stadiumName: "${fn:escapeXml(dto.stadiumName)}",
                region: "${fn:escapeXml(dto.region)}",
                capacity: ${dto.capacity != null ? dto.capacity : 0},
                status: ${dto.status != null ? dto.status : 0},
                latitude: ${dto.latitude != null ? dto.latitude : 37.5665},
                longitude: ${dto.longitude != null ? dto.longitude : 126.9780},
                stadiumCost: ${dto.stadiumCost != null ? dto.stadiumCost : 0},
                addr1: "${fn:escapeXml(dto.addr1)}",
                addr2: "${fn:escapeXml(dto.addr2)}",
                zip: "${fn:escapeXml(dto.zip)}"
            }${!status.last ? ',' : ''}
            </c:forEach>
        ];

        let map = null;
        let marker = null;

        document.addEventListener('DOMContentLoaded', function() {
            initMap();
            setupSearchForm();

            if (stadiumData.length > 0) {
                changeStadium(stadiumData[0].stadiumId);
            }
        });

        function initMap() {
            // 기본 서울시청 위치 지정
            map = L.map('map').setView([37.5665, 126.9780], 13);
            
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                maxZoom: 19,
                attribution: '© OpenStreetMap'
            }).addTo(map);

            // 레이아웃이 그려진 후 지도 타일의 크기를 강제로 재계산하여 보정
            setTimeout(function() {
                if (map) map.invalidateSize();
            }, 300);
        }

        function changeStadium(stadiumId) {
            if (!stadiumId) return;

            const stadium = stadiumData.find(item => item.stadiumId == stadiumId);
            if (!stadium) return;

            document.getElementById('stadiumSelect').value = stadiumId;

            document.getElementById('displayStadiumName').innerText = stadium.stadiumName;
            document.getElementById('displayRegionTag').innerHTML = `<i class="bi bi-tag me-1"></i>` + stadium.region;
            
            const fullAddr = (stadium.addr1 || '') + ' ' + (stadium.addr2 || '');
            document.getElementById('displayAddress').innerText = fullAddr.trim() || '주소 정보 없음';
            document.getElementById('displayRegion').innerText = stadium.region || '-';
            
            const capText = stadium.capacity > 0 ? stadium.capacity.toLocaleString() + '명' : '-';
            document.getElementById('displayCapacity').innerText = capText;

            const costText = stadium.stadiumCost > 0 ? stadium.stadiumCost.toLocaleString() + '원' : '-';
            document.getElementById('displayCost').innerText = costText;

            const statusBadge = document.getElementById('displayStatus');
            if (stadium.status === 1) {
                statusBadge.innerText = '예약 가능';
                statusBadge.className = 'badge-status badge-available';
            } else {
                statusBadge.innerText = '예약 불가';
                statusBadge.className = 'badge-status badge-unavailable';
            }

            const lat = parseFloat(stadium.latitude);
            const lng = parseFloat(stadium.longitude);

            if (!isNaN(lat) && !isNaN(lng)) {
                map.setView([lat, lng], 15);

                if (marker) {
                    map.removeLayer(marker);
                }

                marker = L.marker([lat, lng]).addTo(map)
                    .bindPopup(`<b>${stadium.stadiumName}</b><br>${fullAddr}`)
                    .openPopup();
            }

            setTimeout(function() {
                if (map) map.invalidateSize();
            }, 100);
        }

        function setupSearchForm() {
            const schType = document.querySelector('#schType');
            const stadiumNameKeyword = document.querySelector('#stadiumNameKeyword');
            const regionKeyword = document.querySelector('#regionKeyword');
            const kwd = document.querySelector('#kwd');
            const form = document.querySelector('#stadiumSearchForm');

            function changeSearchInput() {
                const isRegion = schType.value === 'region';
                stadiumNameKeyword.style.display = isRegion ? 'none' : 'block';
                regionKeyword.style.display = isRegion ? 'block' : 'none';
            }

            schType.addEventListener('change', function() {
                stadiumNameKeyword.value = '';
                regionKeyword.value = '';
                changeSearchInput();
            });

            form.addEventListener('submit', function() {
                if (schType.value === 'region') {
                    kwd.value = regionKeyword.value;
                } else {
                    kwd.value = stadiumNameKeyword.value.trim();
                }
            });

            changeSearchInput();
        }

        function goBooking() {
            const select = document.getElementById('stadiumSelect');
            const stadiumId = select.value;
            if (!stadiumId) {
                alert('선택된 경기장이 없습니다.');
                return;
            }
            location.href = '${pageContext.request.contextPath}/booking/write?stadiumId=' + stadiumId;
        }
    </script>
</body>
</html>