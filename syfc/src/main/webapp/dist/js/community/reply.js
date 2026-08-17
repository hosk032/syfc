/**
 * 댓글 관련 JavaScript
 */


/* ======================================================
   댓글 목록 조회
   ====================================================== */

document.addEventListener('DOMContentLoaded', function() {
    loadReply();
});


function loadReply() {

    const replyArea = document.querySelector('#replyArea');
    if(!replyArea) {
        return;
    }

    const bnum = replyArea.dataset.bnum;

    fetch(
        contextPath +
        '/community/reply/replyList?bnum=' +
        encodeURIComponent(bnum)
    )
    .then(response => {
        if(!response.ok) {
            throw new Error('댓글 조회 실패');
        }

        return response.text();

    })
    .then(html => {
        replyArea.innerHTML = html;
    })
	.catch(error => {
	    // console.error(error);

	    if(error.message === 'LOGIN_REQUIRED') {
	        location.href =
	            contextPath +
	            '/community/board/boardDetail?bnum=' +
	            encodeURIComponent(bnum);
	        return;
	    }

	    replyArea.innerHTML ='<div class="text-danger">댓글을 불러오지 못했습니다.</div>';
	});

}

// 댓글 등록
document.addEventListener('submit', function(e) {

    // 댓글 등록 폼이 아니면 종료
    if(e.target.id !== 'replyForm') {
        return;
    }

    e.preventDefault();

    const form = e.target;

    const formData = new FormData(form);

    fetch(
        contextPath +
        '/community/reply/replyInsert',
        {
            method: 'POST',
            body: formData
        }
    )
    .then(response => {

        if(!response.ok) {
            throw new Error('댓글 등록 실패');
        }

        return response.text();

    })
    .then(html => {

        const replyArea =
            document.querySelector('#replyArea');

        if(replyArea) {
            replyArea.innerHTML = html;
        }
    })
    .catch(error => {
        // console.error(error);
        alert('댓글 등록에 실패했습니다.');
    });
});


document.addEventListener('click', function(e) {

	// 댓글 수정 버튼
    const editButton = e.target.closest('.editReply');

    if(editButton) {
        const replyNum = editButton.dataset.replyNum;
        editReply(replyNum);
        return;
    }

	// 댓글 수정 저장 버튼
    const saveButton = e.target.closest('.saveReply');

    if(saveButton) {
        const replyNum = saveButton.dataset.replyNum;
        saveReply(replyNum);
        return;
    }

	// 댓글 수정 취소 버튼
    const cancelButton = e.target.closest('.cancelReply');

    if(cancelButton) {

        const replyNum = cancelButton.dataset.replyNum;
        cancelReply(replyNum);
        return;
    }

	// 댓글 삭제 버튼
    const deleteButton = e.target.closest('.deleteReply');

    if(deleteButton) {
        const replyNum = deleteButton.dataset.replyNum;
        deleteReply(replyNum);
        return;
    }

	// 댓글 더보기
	const moreButton = e.target.closest('.reply-more-btn');

	if(moreButton) {

	    const replyArea = document.querySelector('#replyArea');

	    const replyList = replyArea.querySelector('.reply-list');

	    if(!replyArea || !replyList) {
	        return;
	    }

	    const currentOffset = Number(replyList.dataset.offset) || 0;
	    const size = Number(replyList.dataset.size) || 5;
	    const totalCount =  Number(replyList.dataset.totalCount) || 0;
	    const bnum = replyArea.dataset.bnum;
	    const nextOffset = currentOffset + size;


	    fetch(
	        contextPath +
	        '/community/reply/replyList?bnum=' +
	        encodeURIComponent(bnum) +
	        '&offset=' +
	        nextOffset
	    )
	    .then(response => {

	        if(!response.ok) {
	            throw new Error('댓글 더보기 실패');
	        }

	        return response.text();

	    })
	    .then(html => {

	        const temp =
	            document.createElement('div');

	        temp.innerHTML = html;


	        const newReplyList =
	            temp.querySelector('.reply-list');

	        if(!newReplyList) {
	            return;
	        }


	        // 새 댓글만 가져오기
	        const newReplies =
	            newReplyList.querySelectorAll('.reply-item');


				const moreWrap =
				    replyList.querySelector('.reply-more-wrap');
	
				newReplies.forEach(reply => {
	
				    if(moreWrap) {
				        replyList.insertBefore(reply, moreWrap);
				    } else {
				        replyList.appendChild(reply);
				    }
	
				});

	        // offset 갱신
	        replyList.dataset.offset = nextOffset;

	        // 전체 댓글 수
	        replyList.dataset.totalCount =
	            newReplyList.dataset.totalCount;


	        // 더 불러올 댓글이 없으면 버튼 제거
	        if(nextOffset + size >= totalCount) {

	            const moreWrap =
	                replyList.querySelector('.reply-more-wrap');

	            if(moreWrap) {
	                moreWrap.remove();
	            }

	        }

	    })
	    .catch(error => {

	        // console.error(error);

	        alert('댓글을 더 불러오지 못했습니다.');

	    });

	    return;
	}
	
	
	
});

// 댓글 수정
function editReply(replyNum) {

    const replyItem = document.querySelector('.reply-item[data-reply-num="' + replyNum + '"]');
    if(!replyItem) {
        return;
    }

    // 이미 수정 중이면 실행하지 않음
    if(replyItem.classList.contains('editing')) {
        return;
    }


    const contentDiv = replyItem.querySelector('.reply-content');

    const buttonsDiv = replyItem.querySelector('.reply-buttons');


    if(!contentDiv || !buttonsDiv) {
        return;
    }


    // 기존 댓글 내용
    const originalContent = contentDiv.textContent.trim();

    // 수정 취소할 때 사용할 원래 내용 저장
    replyItem.dataset.originalContent = originalContent;

    // 수정 상태
    replyItem.classList.add('editing');

    const textarea = document.createElement('textarea');

    textarea.className = 'form-control reply-edit-textarea';

    textarea.rows = 3;

    textarea.value = originalContent;

	// 기존 댓글 내용을 textarea로 변경
    contentDiv.innerHTML = '';

    contentDiv.appendChild(textarea);

	// 수정 버튼 저장 및 취소 버튼으로 변경
    buttonsDiv.innerHTML = `
        <button type="button"
                class="btn btn-sm btn-primary saveReply"
                data-reply-num="${replyNum}">
            저장
        </button>

        <button type="button"
                class="btn btn-sm btn-light cancelReply"
                data-reply-num="${replyNum}">
            취소
        </button>
    `;

    // textarea 포커스
    textarea.focus();

}

// 댓글 수정 저장
function saveReply(replyNum) {

    const replyItem =
        document.querySelector(
            '.reply-item[data-reply-num="' +
            replyNum +
            '"]'
        );

    if(!replyItem) {
        return;
    }


    const textarea = replyItem.querySelector('.reply-edit-textarea');

    if(!textarea) {
        return;
    }


    // 수정한 댓글 내용
    const newContent = textarea.value.trim();

	// 유효성 검사
    if(newContent === '') {
        alert('댓글 내용을 입력하세요.');
        textarea.focus();
        return;
    }


    const replyArea = document.querySelector('#replyArea');

    if(!replyArea) {
        return;
    }

    const bnum = replyArea.dataset.bnum;

	// 서버 데이터 전송
    const formData = new FormData();

    formData.append('reply_num', replyNum);


    formData.append('r_content', newContent);


    formData.append('bnum',bnum);

    fetch(contextPath + '/community/reply/replyUpdate',
        {
            method: 'POST',
            body: formData
        }
    )
    .then(response => {
        if(!response.ok) {
            throw new Error('댓글 수정 실패');
        }
        return response.text();

    })
    .then(html => {

        // 수정 완료 후 댓글 목록 다시 출력
        replyArea.innerHTML = html;

    })
    .catch(error => {
        // console.error(error);
        alert('댓글 수정에 실패했습니다.');
    });

}

// 댓글 수정 취소
function cancelReply(replyNum) {

    const replyItem = document.querySelector('.reply-item[data-reply-num="' + replyNum +'"]');

    if(!replyItem) {
        return;
    }

    const contentDiv = replyItem.querySelector('.reply-content');
    const buttonsDiv = replyItem.querySelector('.reply-buttons');

    if(!contentDiv || !buttonsDiv) {
        return;
    }

	// 수정 전 기존 내용
    const originalContent =
        replyItem.dataset.originalContent || '';

    contentDiv.textContent = originalContent;

    buttonsDiv.innerHTML = `
        <button type="button"
                class="btn btn-sm btn-light editReply"
                data-reply-num="${replyNum}">
            수정
        </button>

        <button type="button"
                class="btn btn-sm btn-light deleteReply"
                data-reply-num="${replyNum}">
            삭제
        </button>
    `;

    replyItem.classList.remove('editing');

    // 저장했던 원래 내용 제거
    delete replyItem.dataset.originalContent;

}

// 댓글 삭제
function deleteReply(replyNum) {

    if(!confirm('댓글을 삭제하시겠습니까?')) {
        return;
    }


    const replyArea = document.querySelector('#replyArea');

    if(!replyArea) {
        return;
    }

    const bnum = replyArea.dataset.bnum;

    const formData = new FormData();

    formData.append('reply_num', replyNum);


    formData.append('bnum', bnum);

    fetch(
        contextPath +
        '/community/reply/replyDelete',
        {
            method: 'POST',
            body: formData
        }
    )
    .then(response => {
        if(!response.ok) {
            throw new Error('댓글 삭제 실패');
        }
        return response.text();

    })
    .then(html => {
        // 삭제 완료 후 댓글 목록 갱신
        replyArea.innerHTML = html;

    })
    .catch(error => {
        // console.error(error);
        alert('댓글 삭제에 실패했습니다.');
    });

}