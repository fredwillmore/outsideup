validate = (thisform) ->
  if thisform.firstname.value=="" || thisform.lastname.value=="" || thisform.email.value==""
    alert("First and last name and email address are required.");
    return false;
  else
    return true;
