package stu.kms.mapper;

import stu.kms.domain.BoardAttachVO;

import java.util.List;

public interface BoardAttachMapper {

    void insert(BoardAttachVO vo);

    void delete(String uuid);

    List<BoardAttachVO> findByBno(Long bno);

    void deleteAll(Long bno);
}
