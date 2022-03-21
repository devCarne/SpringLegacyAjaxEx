package stu.kms.mapper;

import org.apache.ibatis.annotations.Param;
import stu.kms.domain.BoardVO;
import stu.kms.domain.Criteria;

import java.util.List;

public interface BoardMapper {

    int getTotalCount(Criteria criteria);

    List<BoardVO> getList();

    List<BoardVO> getListWithPaging(Criteria criteria);

    void insert(BoardVO board);

    void insertSelectKey(BoardVO board);

    BoardVO read(Long bno);

    int delete(Long bno);

    int update(BoardVO board);

    public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
}
