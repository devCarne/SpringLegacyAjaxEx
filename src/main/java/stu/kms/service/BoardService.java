package stu.kms.service;

import stu.kms.domain.BoardAttachVO;
import stu.kms.domain.BoardVO;
import stu.kms.domain.Criteria;

import java.util.List;

public interface BoardService {

    void register(BoardVO board);

    BoardVO get(Long bno);

    boolean modify(BoardVO board);

    boolean remove(Long bno);

    public int getTotal(Criteria criteria);

    List<BoardVO> getList(Criteria criteria);

    List<BoardAttachVO> getAttachList(Long bno);
}
