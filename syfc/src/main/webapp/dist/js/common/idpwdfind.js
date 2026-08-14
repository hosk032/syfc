function idFind() {

    const userName = document.querySelector("#userName").value;
    const email = document.querySelector("#email").value;

    fetch(contextPath + "/member/idFind", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "AJAX": "true"
        },
        body:
            "userName=" + encodeURIComponent(userName)
            + "&email=" + encodeURIComponent(email)
    })

    .then(response => {
        if (!response.ok) {
            throw new Error("HTTP 오류 : " + response.status);
        }
        return response.json();
    })

    .then(data => {
        const result = document.querySelector("#findIdResult");
        result.innerHTML = "";
        const list = data.list;
        if (list.length === 0) {
            result.textContent =
                "일치하는 회원정보가 없습니다.";
            return;
        }

        list.forEach(dto => {
            const p = document.createElement("p");
            p.textContent = "아이디는 " + dto.userId + " 입니다.";

            result.appendChild(p);
        });

    })

    .catch(error => {

        console.error(error);

    });
}

function sendOk() {

    const userId = document.querySelector("#userId").value;
    const userName1 = document.querySelector("#userName1").value.trim();
	
	fetch(contextPath + "/member/pwdFind", {
	    method: "POST",
	    headers: {
	        "Content-Type": "application/x-www-form-urlencoded",
			"AJAX": "true"
	    },
	    body:
	        "userId=" + encodeURIComponent(userId) +
	        "&userName1=" + encodeURIComponent(userName1)
	})
	.then(response => response.json())
	.then(data => {
		const result = document.querySelector("#result");

		  result.textContent = data.message;

	})
	.catch(error => {
	    console.error(error);
	});
}
