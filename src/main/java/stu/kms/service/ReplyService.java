package stu.kms.service;

import stu.kms.domain.Criteria;
import stu.kms.domain.ReplyVO;

import java.util.List;

public interface ReplyService {
    int register(ReplyVO vo);

    ReplyVO get(Long rno);

    int modify(ReplyVO vo);

    int remove(Long rno);

    List<ReplyVO> getList(Criteria criteria, Long bno);
}
