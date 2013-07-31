
function isFunction(object) {
 return typeof object == 'function';
}


function formatDateTimeSql(date_str) {
  return Date(date_str).toLocaleString();
}

//first, checks if it isn't implemented yet
if (!String.prototype.format) {
  String.prototype.format = function() {
    var args = arguments;
    return this.replace(/{(\d+)}/g, function(match, number) { 
      return typeof args[number] != 'undefined'
        ? args[number]
        : match
      ;
    });
  };
}

function currencyFormat(value) { 
  return "R$ "+parseFloat((value).toString()).toFixed(2);
}

function timeRelativeString(current, previous) {

    var msPerMinute = 60 * 1000;
    var msPerHour = msPerMinute * 60;
    var msPerDay = msPerHour * 24;
    var msPerMonth = msPerDay * 30;
    var msPerYear = msPerDay * 365;

    var elapsed = current - previous;

    if (elapsed < msPerMinute) {
         return 'à  ' +Math.round(elapsed/1000) + ' segundos';   
    }

    else if (elapsed < msPerHour) {
         return 'à  ' +Math.round(elapsed/msPerMinute) + ' minutos';   
    }

    else if (elapsed < msPerDay ) {
         return 'à  ' + Math.round(elapsed/msPerHour ) + ' horas';   
    }

    else if (elapsed < msPerMonth) {
        return 'à  ' + Math.round(elapsed/msPerDay) + ' dias';   
    }

    else if (elapsed < msPerYear) {
        return 'à  ' + Math.round(elapsed/msPerMonth) + ' meses';   
    }

    else {
        return 'à  ' + Math.round(elapsed/msPerYear ) + ' anos';   
    }
}