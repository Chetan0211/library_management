
document.addEventListener('DOMContentLoaded', function(){
    let button = document.getElementById('author_form_submit');
    button.addEventListener('click', function(event){
        
        let author_name = document.getElementById('admin_name')?.value;
        console.log(author_name);
        if(author_name.trim().length <= 1){
            event.preventDefault();
            alert("Please enter valid name and should be greater than 2 characters");
        }
    })
})