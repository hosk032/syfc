document.addEventListener("DOMContentLoaded", function(){


    const signupBtn =
        document.querySelector("#singupBtn");


    const signupModal =
        document.querySelector("#singupModal");



    if(signupBtn && signupModal){


        signupBtn.addEventListener("click", function(){


            const modal =
            new bootstrap.Modal(signupModal);


            modal.show();


        });


    }


});