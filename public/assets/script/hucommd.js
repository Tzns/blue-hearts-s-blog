 var Val={
          //正则表达式验证是否为手机号码
          isMobile:function(s){return this.test(s,/^1[34578]\d{9}$/)},  
          isNumber:function(s,d){return !isNaN(s.nodeType==1?s.value:s)&&(!d||!this.test(s,"^-?[0-9]*\\.[0-9]*$"))},
          isEmpty:function(s){return !jQuery.isEmptyObject(s)},test:function(s,p){s=s.nodeType==1?s.value:s;return new RegExp(p).test(s)}
};



//Date扩展
Date.prototype.Format = function (fmt) { //author: meizz 
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}
var getQueryString=function (name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
}
var dateConfig = {
    locale: {
        applyLabel: '确定',
        cancelLabel: '取消',
        fromLabel: '起始时间',
        toLabel: '结束时间',
        customRangeLabel: '自定义',
        daysOfWeek: ['日', '一', '二', '三', '四', '五', '六'],
        monthNames: ['一月', '二月', '三月', '四月', '五月', '六月',
            '七月', '八月', '九月', '十月', '十一月', '十二月'],
        firstDay: 1,
        format: 'YYYY年MM月DD日'
    },
    options : {
        theme: 'mobiscroll', //日期选择器使用的主题
        lang: 'zh', //使用语言
        display: 'bottom', //显示方式
        dateFormat: 'yy-mm-dd'
    }
}
var dateFn =function (name, vm) {
    vm.getData();

    $(name).daterangepicker({
        locale: dateConfig.locale,
        startDate: vm.input.BeginTime,
        endDate: vm.input.EndTime
    }).on('apply.daterangepicker', function (e, p) {
        vm.input.BeginTime = p.startDate.format('YYYY-MM-DD');
        vm.input.EndTime = p.endDate.format('YYYY-MM-DD');
        vm.getData();
    });
}




//时间基本变量
var date = new Date();
var monthDate = date.getDate();
//本月开始时间
var monthStartTime = date.Format('yyyy-MM-') + '01';
//本月结束时间
var monthLastTime = date.Format('yyyy-MM-dd');
//今日时间
var toDayTime = date.Format('yyyy-MM-dd');
//昨日
date.setDate(date.getDate() - 1);
var YesterDayTime = date.Format('yyyy-MM-dd');
//本周开始
date = new Date();
day = date.getDay() === 0 ? 7 : date.getDay();
date.setDate(date.getDate() - (day - 1));
var thisStartWeekTime = date.Format('yyyy-MM-dd');
//本周结束
date = new Date();
day = date.getDay() === 0 ? 7 : date.getDay();
date.setDate((date.getDate() - day) + 7);
var thisLastWeekTime = date.Format('yyyy-MM-dd');
//上周开始
date = new Date();
day = date.getDay() === 0 ? 7 : date.getDay();
date.setDate(date.getDate() - (day + 6));
var lastStartWeekTime = date.Format('yyyy-MM-dd');
//上周结束
date = new Date();
day = date.getDay() === 0 ? 7 : date.getDay();
date.setDate((date.getDate() - day));
var lastLastWeekTime = date.Format('yyyy-MM-dd');
//前多少天
var getFrontDay = function (count) {
    date = new Date();
    //day = date.getDay() === 0 ? 7 : date.getDay();
    date.setDate(date.getDate() - count);
    return date.Format('yyyy-MM-dd');
}
var getLastDay = function (count) {
    date = new Date();
    //day = date.getDay() === 0 ? 7 : date.getDay();
    date.setDate(date.getDate() + count);
    return date.Format('yyyy-MM-dd');
}

var standardPost = function (url, args) {
    var form = $("<form method='post'></form>");
    form.attr({ "action": url });
    for (arg in args) {
        var input = $("<input type='hidden'>");
        input.attr({ "name": arg });
        input.val(args[arg]);
        form.append(input);
    }
    form.submit();
}
var date = {
    locale: {
        applyLabel: '确定',
        cancelLabel: '取消',
        fromLabel: '起始时间',
        toLabel: '结束时间',
        customRangeLabel: '自定义',
        daysOfWeek: ['日', '一', '二', '三', '四', '五', '六'],
        monthNames: ['一月', '二月', '三月', '四月', '五月', '六月',
                '七月', '八月', '九月', '十月', '十一月', '十二月'],
        firstDay: 1,
        format: 'YYYY年MM月DD日'
    }
}
//分页配置
var pageOptions = {
    bootstrapMajorVersion: 1,
    currentPage: 1,
    size:"normal",
    itemTexts: function (type, page, current) {
        switch (type) {
            case "first":
                return "首页";
            case "prev":
                return "上页";
            case "next":
                return "下页";
            case "last":
                return "末页";
            case "page":
                return page;
        }
        return "";
    }
}


var hu = {
    ElName:'',
    blockPost: function (el,url,pars,success,fail) {
        App.blockUI({
            target: el,
            animate: true
        });
        $.post(url, pars, function (data) {
            if (data.IsSuccess) {
                success(data);
            } else {
                fail();
            }
            App.unblockUI('#main-div');
        });
    },
    block: function (elName) {
        App.blockUI({
            target: elName,
            animate: true
        });
        this.ElName = elName;
        return this;
    },
    post: function (url, par,fn) {
        //之后加入登录校验跳转
        var elName = this.ElName;
        if (fn !== null && fn !== undefined) {
            $.ajax(url, { type: 'POST', data: par })
                .done(function(data) {
                    if (data.IsSuccess) {
                        fn(data.Data);
                    } else {
                        alert(data.Info);
                    }
                    App.unblockUI(elName);
                }).fail(function() {
                    alert('请求失败');
                });
        } else {
            var dtd = $.Deferred();
          
            $.ajax(url, { type: 'POST', data: par })
                .done(function (data) {
                    if (data.IsSuccess) {
                        dtd.resolve(data.Data);
                        App.unblockUI(elName);
                    } else {
                        deferred.reject();
                    }
                }).fail(function () {
                    alert('请求失败');
                });
            return dtd;
        }
        return this;
    },
    postData: function (url, vm) {
        //之后加入登录校验跳转
        var elName = this.ElName;
            $.ajax(url, { type: 'POST', data: vm.input })
                .done(function (data) {
                    if (data.IsSuccess) {
                        vm.data = data.Data;
                        App.unblockUI(elName);
                    } else {
                        alert('请求失败');
                        return false;
                    }
                }).fail(function () {
                    alert('请求失败');
                    return false;
                });
            return this;
    },
    postPage: function (url, vm) {
        var elName = this.ElName;
        $.ajax(url, { type: 'POST', data: vm.input })
            .done(function (data) {
                if (data.IsSuccess) {
                    vm.data = data.Data.Data;
                    pageOptions.totalPages = data.Data.PageCount;
                    pageOptions.currentPage = vm.input.PageIndex;
                    pageOptions.onPageClicked = function (a, b, c, p) {
                        vm.input.PageIndex = p;
                        vm.getData();
                    }
                    $('#example').bootstrapPaginator(pageOptions);
                } else {
                    alert(data.Info);
                }
                
                App.unblockUI(elName);
            }).fail(function () {
                alert('请求失败');
            });
    },
    postPage2: function (url, vm,pageId) {
        var elName = this.ElName;
        $.ajax(url, { type: 'POST', data: vm.input })
            .done(function (data) {
                if (data.IsSuccess) {
                    vm.data = data.Data.Data;
                    if (data.Data.Data.length !== 0) {
                        pageOptions.totalPages = data.Data.PageCount;
                        pageOptions.currentPage = vm.input.PageIndex;
                        pageOptions.onPageClicked = function (a, b, c, p) {
                            vm.input.PageIndex = p;
                            vm.getData();
                        }
                        $(pageId).bootstrapPaginator(pageOptions);
                    }
                } else {
                    alert(data.Info);
                }

                App.unblockUI(elName);
            }).fail(function () {
                alert('请求失败');
            });
    }

}

/**
* 将秒数换成时分秒格式
* 整理：www.jbxue.com
*/

function formatSeconds(value) {
    var theTime = parseInt(value);// 秒
    var theTime1 = 0;// 分
    var theTime2 = 0;// 小时
    if (theTime > 60) {
        theTime1 = parseInt(theTime / 60);
        theTime = parseInt(theTime % 60);
        if (theTime1 > 60) {
            theTime2 = parseInt(theTime1 / 60);
            theTime1 = parseInt(theTime1 % 60);
        }
    }
    var result = "" + parseInt(theTime) + "秒";
    if (theTime1 > 0) {
        result = "" + parseInt(theTime1) + "分" + result;
    }
    if (theTime2 > 0) {
        result = "" + parseInt(theTime2) + "小时" + result;
    }
    return result;
}

var getRow = function (data, colName) {
    var cols = [];
    for (var i = 0; i < data.length; i++) {
        cols.push(data[i][colName]);
    }
    return cols;
}
var getDateRow = function (data, colName) {
    var cols = [];
    for (var i = 0; i < data.length; i++) {
        if (i === 0 || i === data.length - 1) {
            cols.push(new Date(data[i][colName]).Format('yyyy.MM.dd'));
        } else {
            cols.push(new Date(data[i][colName]).Format('MM.dd'));
        }
    }
    return cols;
}
var getDateRow = function (data, colName, is) {
    if (is) {
        return getDateRow(data, colName);
    } else {
        return getRow(data, colName);
    }
}



var getHourDateRow = function (data, colName) {
    var cols = [];
    for (var i = 0; i < data.length; i++) {
        cols.push(new Date(data[i][colName]).Format('yyyy.MM.dd HH'));
    }
    return cols;
}




//导出csv 数据，是否输出表头，传递表头
var JSONToCSVConvertor = function (JSONData, ShowLabel, titleNames) {
    var arrData = typeof JSONData !== 'object' ? JSON.parse(JSONData) : JSONData;
    var CSV = '';

    if (ShowLabel) {
        var row = "";
        if (titleNames !== null) {
            for (var j = 0; j < titleNames.length; j++) {
                row += titleNames[j] + ',';
            }
        } else {
            for (var index in arrData[0]) {
                row += index + ',';
            }
        }

        row = row.slice(0, -1);
        CSV += row + '\r\n';
    }





    for (var i = 0; i < arrData.length; i++) {
        var row = "";
        for (var index in arrData[i]) {
            var arrValue = arrData[i][index] == null ? "" : '="' + arrData[i][index] + '"';
            row += arrValue + ',';
        }
        row.slice(0, row.length - 1);
        CSV += row + '\r\n';
    }

    if (CSV == '') {
        console.error("Invalid data");
        return;
    }

    var fileName = "Result";
    var msieversion = function () {
        var ua = window.navigator.userAgent;
        var msie = ua.indexOf("MSIE ");
        if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) // If Internet Explorer, return version number 
        {
            return true;
        } else { // If another browser, 
            return false;
        }
        return false;
    }
    if (msieversion()) {
        var IEwindow = window.open();
        IEwindow.document.write('sep=,\r\n' + CSV);
        IEwindow.document.close();
        IEwindow.document.execCommand('SaveAs', true, fileName + ".csv");
        IEwindow.close();
    } else {
        var uri = 'data:application/csv;charset=utf-8,\uFEFF' + encodeURI(CSV);
        var link = document.createElement("a");
        link.href = uri;
        link.style = "visibility:hidden";
        link.download = fileName + ".csv";
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }
};

