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

<!-- comment -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">

            <div class="panel-heading">
                <i class="fa fa-comments fa-fw"></i> Reply
                <button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>
            </div>

            <div class="panel-body">
                <ul class="chat">
                </ul>
            </div>

            <div class="panel-footer">
            </div>

        </div>
    </div>
</div>

<%@include file="../includes/footer.jsp"%>

<!-- comment modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">$times;</button>
                <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
            </div>

            <div class="modal-body">
                <div class="form-group">
                    <label>Reply</label>
                    <input class="form-control" name="reply" value="New Reply!!!">
                </div>
                <div class="form-group">
                    <label>Replyer</label>
                    <input class="form-control" name="replyer" value="replyer">
                </div>
                <div class="form-group">
                    <label>Reply Date</label>
                    <input class="form-control" name="replyDate" value="">
                </div>
            </div>

            <div class="modal-footer">
                <button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
                <button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
                <button id="modalRegisterBtn" type="button" class="btn btn-primary">Register</button>
                <button id="modalCloseBtn" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button id="modalClassBtn" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script src="/resources/js/reply.js"></script>
<script>
    $(document).ready(function () {
        var bnoValue = "<c:out value='${board.bno}'/>";
        var replyUL = $(".chat");
        var pageNum = 1;
        var replyPageFooter = $(".panel-footer");

        showList(1);

        //Reply
        function showList(page) {
            replyService.getList(
                {
                    bno: bnoValue,
                    page: page || 1
                },
                function (replyCnt, list) {
                    //새로운 댓글 추가 시 -1페이지를 호출하여 마지막 페이지로 이동하도록 하는 처리.
                    if (page === -1) {
                        pageNum = Math.ceil(replyCnt / 10.0);
                        showList(pageNum);
                        return;
                    }

                    var str = "";

                    if (list == null || list.length === 0) {
                        return;
                    }

                    for (var i = 0; i < list.length || 0; i++) {
                        str +=
                            "<li class='left clearfix' data-rno='" + list[i].rno + "'>" +
                            "   <div>" +
                            "       <div class='header'>" +
                            "           <strong class='primary-font'>[" + list[i].rno + "] " + list[i].replyer + "</strong>" +
                            "           <small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small>" +
                            "       </div>" +
                            "       <p>" + list[i].reply + "</p>" +
                            "   </div>" +
                            "</li>";
                    }
                    replyUL.html(str);

                    showReplayPage(replyCnt);
                });
        }

        //Reply Page
        function showReplayPage(replyCnt) {
            var endNum = Math.ceil(pageNum / 10.0) * 10;
            var startNum = endNum - 9;

            var prev = startNum !== 1;
            var next = false;

            if (endNum * 10 >= replyCnt) {
                endNum = Math.ceil(replyCnt / 10.0);
            }

            if (endNum * 10 < replyCnt) {
                next = true;
            }

            var str = "<ul class='pagination pull-right'>";

            if (prev) {
                str += "<li class='page-item'>" +
                    "       <a class='page-link' href='" + (startNum - 1) + "'>previous</a>" +
                    "   <li>";
            }

            for (var i = startNum; i <= endNum; i++) {
                var active = pageNum === i ? "active" : "";

                str += "<li class='page-item " + active + "'>" +
                    "       <a class='page-link' href='" + i + "'>" + i + "</a>" +
                    "   <li>"
            }

            if (next) {
                str += "<li class='page-item'>" +
                    "       <a class='page-link' href='" + (endNum + 1) + "'>Next</a>" +
                    "   <li>";
            }

            str += "</ul></div>";

            console.log(str);

            replyPageFooter.html(str);
        }

        //reply page click event
        replyPageFooter.on("click", "li a", function (e) {
            e.preventDefault();
            pageNum = $(this).attr("href");
            showList(pageNum);
        });

        //new reply Modal
        var modal = $(".modal");
        var modalInputReply = modal.find("input[name='reply']");
        var modalInputReplyer = modal.find("input[name='replyer']");
        var modalInputReplyDate = modal.find("input[name='replyDate']");

        var modalModBtn = $("#modalModBtn");
        var modalRemoveBtn = $("#modalRemoveBtn");
        var modalRegisterBtn = $("#modalRegisterBtn");

        $("#addReplyBtn").on("click", function (e) {
            modal.find("input").val("");
            modalInputReplyDate.closest("div").hide();
            modal.find("button[id !='modalCloseBtn']").hide();

            modalRegisterBtn.show();
            $(".modal").modal("show");
        });

        //reply register
        modalRegisterBtn.on("click", function (e) {
            var reply = {
                reply : modalInputReply.val(),
                replyer : modalInputReplyer.val(),
                bno : bnoValue
            };
            replyService.add(reply, function (result) {
                alert(result);

                modal.find("input").val("");
                modal.modal("hide");

                showList(-1);
            });
        });

        //reply manage modal
        $(".chat").on("click", "li", function (e) {
            var rno = $(this).data("rno");
            replyService.get(rno, function (reply) {
                modalInputReply.val(reply.reply);
                modalInputReplyer.val(reply.replyer).attr("readonly","readonly");
                modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly","readonly");
                modal.data("rno", reply.rno);

                modal.find("button[id !='modalCloseBtn']").hide();
                modalModBtn.show();
                modalRemoveBtn.show();

                $(".modal").modal("show");
            });
        });

        //reply modify
        modalModBtn.on("click", function (e) {
            var reply = {
                rno : modal.data("rno"),
                reply : modalInputReply.val()
            }

            replyService.update(reply, function (result) {
                alert(result);
                modal.modal("hide");
                showList(pageNum);
            });
        });

        //reply delete
        modalRemoveBtn.on("click", function (e) {
            var rno = modal.data("rno");

            replyService.remove(rno, function (result) {
                alert(result);
                modal.modal("hide");
                showList(pageNum);
            });
        });
    });

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