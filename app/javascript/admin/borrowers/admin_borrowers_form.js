
document.addEventListener('DOMContentLoaded', function(){
    button = document.getElementById('borrower_form_submit');
    button.addEventListener('click', function(event){
        event.preventDefault();
        alert('clicked');
    })
})