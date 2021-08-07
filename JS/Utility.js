function getMonthString(i){
    switch(i){
    case 0:
        return "Jan";
    case 1:
        return "Feb";
    case 2:
        return "Mar";
    case 3:
        return "Apr";
    case 4:
        return "May";
    case 5:
        return "Jun";
    case 6:
        return "Jul";
    case 7:
        return "Aug";
    case 8:
        return "Sep";
    case 9:
        return "Oct";
    case 10:
        return "Nov";
    case 11:
        return "Dec";
    }
}

function getNumString(i){
    return i<10?'0'+i.toString():i.toString();
}

function getDate(){
    var monthStr = getMonthString(new Date().getMonth());
    var dateStr = getNumString(new Date().getDate());
    return monthStr+" "+dateStr;
}
function getTime(){
    var hourStr = new Date().getHours().toString();
    var minuteStr = getNumString(new Date().getMinutes());
    return hourStr+":"+minuteStr;
}
