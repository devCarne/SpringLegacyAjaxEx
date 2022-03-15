package stu.kms.mapper;

import stu.kms.domain.BoardVO;
import stu.kms.domain.Criteria;

import java.util.List;

public interface BoardMapper {

    List<BoardVO> getList();

    List<BoardVO> getListWithPaging(Criteria criteria);

    void insert(BoardVO board);

    void insertSelectKey(BoardVO board);

    BoardVO read(Long bno);

    int delete(Long bno);

    int update(BoardVO board);
}
