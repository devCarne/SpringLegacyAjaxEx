package stu.kms.mapper;

import org.apache.ibatis.annotations.Param;
import stu.kms.domain.Criteria;
import stu.kms.domain.ReplyVO;

import java.util.List;

public interface ReplyMapper {

    int insert(ReplyVO vo);

    ReplyVO read(Long rno);

    int delete(Long rno);

    int update(ReplyVO vo);

    List<ReplyVO> getListWithPaging(@Param("criteria")Criteria criteria, @Param("bno") Long bno);
}
