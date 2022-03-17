<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp"%>

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Board Read</h1>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">Board Read Page</div>
            <div class="panel-body">
                    <div class="form-group">
                        <label>Bno</label>
                        <input class="form-control" name="bno" value="${board.bno}" readonly>
                    </div>
                    <div>
                        <label>Title</label>
                        <input class="form-control" name="title" value="${board.title}" readonly>
                    </div>
                    <div class="form-group">
                        <label>Text area</label>
                        <textarea class="form-control" rows="3" name="content" readonly>${board.content}</textarea>
                    </div>
                    <div class="form-group">
                        <label>Writer</label>
                        <input class="form-control" name="writer" value="${board.writer}" readonly>
                    </div>
                    <button data-oper="modify" class="btn btn-default">Modify</button>
                    <button data-oper="list" class="btn btn-info">List</button>
                <form id="operForm" action="/board/modify" method="get">
                    <input type="hidden" id="bno" name="bno" value="<c:out value='${board.bno}'/>">
                    <input type="hidden" name="pageNum" value="<c:out value='${criteria.pageNum}'/>">
                    <input type="hidden" name="amount" value="<c:out value='${criteria.amount}'/>">
                    <input type="hidden" name="type" value="<c:out value='${criteria.type}'/>">
                    <input type="hidden" name="keyword" value="<c:out value='${criteria.keyword}'/>">
                </form>
            </div>
        </div>
    </div>
</div>

<%@include file="../includes/footer.jsp"%>

<script src="/resources/js/reply.js"></script>
<script>
    console.log("=============");
    console.log("JS TEST");

    var bnoValue = "<c:out value='${board.bno}'/>";

    // replyService.add(
    //     {reply:"JS Test", replyer:"tester", bno:bnoValue},
    //     function (result) {
    //         alert("RESULT : " + result);
    //     }
    // );

    // replyService.getList({bno: bnoValue, page: 1}, function (list) {
    //     for (var i = 0; i < list.length || 0; i++) {
    //         console.log(list[i]);
    //     }
    // });

    replyService.remove(
        12,
        function (count) {
            console.log(count);
            if (count === "success") {
                alert("REMOVED");
            }
        },
        function (err) {
            alert("ERROR...");
        }
    );
</script>
<script>
    $(document).ready(function () {
        var operForm = $("#operForm");

        $("button[data-oper='modify']").on("click", function () {
            operForm.attr("action", "/board/modify").submit();
        });

        $("button[data-oper='list']").on("click", function () {
            operForm.find("#bno").remove();
            operForm.attr("action", "/board/list")
            operForm.submit();
        });
    });
</script>