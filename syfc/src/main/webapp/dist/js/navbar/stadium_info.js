const stadiumData = {
        "1": {
            name: "쌍용축구경기장 (마포)",
            regionGroup: "seoul",
            region: "서울특별시 마포구",
            address: "서울특별시 마포구 월드컵로 240",
            capacity: "정규 11 vs 11 (최대 500명 수용)",
            facilities: "야간 조명, 전용 주차장, 샤워실, 음료 자판기",
            status: "available",
            statusText: "예약가능",
            lat: 37.568256,
            lng: 126.897240
        },
        "2": {
            name: "마포구민체육센터 축구장",
            regionGroup: "seoul",
            region: "서울특별시 마포구",
            address: "서울특별시 마포구 포은로 2-1",
            capacity: "풋살 6 vs 6 / 축구 11 vs 11 (약 200명)",
            facilities: "무료 주차 2시간, 샤워실, 관람석",
            status: "available",
            statusText: "예약가능",
            lat: 37.550182,
            lng: 126.903123
        },
        "3": {
            name: "수원월드컵경기장 인조잔디구장",
            regionGroup: "gyeonggi",
            region: "경기도 수원시",
            address: "경기도 수원시 팔달구 월드컵로 310",
            capacity: "정규 11 vs 11 (약 300명)",
            facilities: "조명탑, 주차장, 샤워실, 매점",
            status: "available",
            statusText: "예약가능",
            lat: 37.286542,
            lng: 127.036921
        },
        "4": {
            name: "성남 탄천종합운동장 보조구장",
            regionGroup: "gyeonggi",
            region: "경기도 성남시",
            address: "경기도 성남시 분당구 탄천로 215",
            capacity: "정규 11 vs 11 (약 200명)",
            facilities: "주차시설, 샤워실, 관람석, 음수대",
            status: "unavailable",
            statusText: "예약불가 (잔디보수)",
            lat: 37.410115,
            lng: 127.127812
        },
        "5": {
            name: "인천아시아드 보조경기장",
            regionGroup: "incheon",
            region: "인천광역시 서구",
            address: "인천광역시 서구 봉수대로 806",
            capacity: "정규 11 vs 11 (약 400명)",
            facilities: "조명시설, 대형 주차장, 라커룸, 샤워실",
            status: "available",
            statusText: "예약가능",
            lat: 37.548123,
            lng: 126.668512
        },
        "6": {
            name: "부산아시아드 보조경기장",
            regionGroup: "busan",
            region: "부산광역시 연제구",
            address: "부산광역시 연제구 월드컵대로 344",
            capacity: "정규 11 vs 11 (약 500명)",
            facilities: "야간 조명, 지하 주차장, 샤워실",
            status: "available",
            statusText: "예약가능",
            lat: 35.190145,
            lng: 129.058231
        },
        "7": {
            name: "대구스타디움 보조구장",
            regionGroup: "daegu",
            region: "대구광역시 수성구",
            address: "대구광역시 수성구 야시골로 256",
            capacity: "정규 11 vs 11 (약 300명)",
            facilities: "전용 주차장, 야간 조명, 휴게실",
            status: "available",
            statusText: "예약가능",
            lat: 35.829412,
            lng: 128.689654
        },
        "8": {
            name: "광주월드컵 보조경기장",
            regionGroup: "gwangju",
            region: "광주광역시 서구",
            address: "광주광역시 서구 금화로 240",
            capacity: "정규 11 vs 11 (약 250명)",
            facilities: "주차장, 샤워실, 음수대, 야간 조명",
            status: "available",
            statusText: "예약가능",
            lat: 35.132845,
            lng: 126.873211
        },
        "9": {
            name: "대전월드컵 보조구장",
            regionGroup: "daejeon",
            region: "대전광역시 유성구",
            address: "대전광역시 유성구 노은로 21",
            capacity: "정규 11 vs 11 (약 300명)",
            facilities: "조명탑, 주차장, 라커룸",
            status: "unavailable",
            statusText: "예약불가 (대회진행중)",
            lat: 36.368123,
            lng: 127.325812
        },
        "10": {
            name: "춘천 송암스포츠타운 축구장",
            regionGroup: "gangwon",
            region: "강원특별자치도 춘천시",
            address: "강원특별자치도 춘천시 스포츠타운길 124",
            capacity: "정규 11 vs 11 (약 400명)",
            facilities: "경관 조명, 주차시설, 샤워실, 매점",
            status: "available",
            statusText: "예약가능",
            lat: 37.854123,
            lng: 127.697812
        }
    };

    let map, marker;

    function initMap(lat, lng) {
        map = L.map('map').setView([lat, lng], 14);

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '© OpenStreetMap'
        }).addTo(map);

        marker = L.marker([lat, lng]).addTo(map);
    }

    function updateStadiumOptions() {
        const region = document.getElementById('regionSelect').value;
        const stadiumSelect = document.getElementById('stadiumSelect');
        
        stadiumSelect.innerHTML = '';

        for (let key in stadiumData) {
            if (region === 'all' || stadiumData[key].regionGroup === region) {
                const opt = document.createElement('option');
                opt.value = key;
                opt.innerText = stadiumData[key].name;
                stadiumSelect.appendChild(opt);
            }
        }
        
        if(stadiumSelect.options.length > 0) {
            searchStadium();
        } else {
            alert("선택하신 지역에 등록된 경기장이 없습니다.");
        }
    }

    function searchStadium() {
        const selectedId = document.getElementById('stadiumSelect').value;
        const data = stadiumData[selectedId];

        if (!data) return;

        document.getElementById('displayStadiumName').innerText = data.name;
        document.getElementById('displayRegionTag').innerHTML = `<i class="bi bi-tag me-1"></i>${data.region}`;
        document.getElementById('displayAddress').innerText = data.address;
        document.getElementById('displayRegion').innerText = data.region;
        document.getElementById('displayCapacity').innerText = data.capacity;
        document.getElementById('displayFacilities').innerText = data.facilities;

        const statusBadge = document.getElementById('displayStatus');
        const bookingBtn = document.getElementById('bookingBtn');

        if (data.status === 'available') {
            statusBadge.className = "status-badge status-available";
            statusBadge.innerText = "예약가능";
            bookingBtn.disabled = false;
            bookingBtn.innerText = "이 경기장 예약하기";
            bookingBtn.style.backgroundColor = "#6b4ba1";
        } else {
            statusBadge.className = "status-badge status-unavailable";
            statusBadge.innerText = data.statusText;
            bookingBtn.disabled = true;
            bookingBtn.innerText = "현재 예약 불가";
            bookingBtn.style.backgroundColor = "#6c757d";
        }

        if (map && marker) {
            map.setView([data.lat, data.lng], 14);
            marker.setLatLng([data.lat, data.lng]);
        }
    }

    window.onload = function() {
        initMap(stadiumData["1"].lat, stadiumData["1"].lng);
        updateStadiumOptions();

        document.querySelector("#singupBtn").addEventListener("click", function(){
            const modal = new bootstrap.Modal(document.querySelector("#singupModal"));
            modal.show();
        });
    };