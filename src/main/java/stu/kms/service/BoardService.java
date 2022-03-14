package stu.kms.service;

import stu.kms.domain.BoardVO;

import java.util.List;

public interface BoardService {

    void register(BoardVO board);

    BoardVO get(Long bno);

    boolean modify(BoardVO board);

    boolean remove(Long bno);

    List<BoardVO> getList();
}
