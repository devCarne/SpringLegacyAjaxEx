package stu.kms.mapper;

import stu.kms.domain.BoardVO;

import java.util.List;

public interface BoardMapper {

    List<BoardVO> getList();

    void insert(BoardVO board);

    void insertSelectKey(BoardVO board);

    BoardVO read(Long bno);

    int delete(Long bno);

    int update(BoardVO board);
}
