package stu.kms.service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;
import stu.kms.domain.Criteria;
import stu.kms.domain.ReplyPageDTO;
import stu.kms.domain.ReplyVO;
import stu.kms.mapper.ReplyMapper;

import java.util.List;

@Service
@AllArgsConstructor
@Log4j
public class ReplyServiceImpl implements ReplyService{

    private ReplyMapper mapper;

    @Override
    public int register(ReplyVO vo) {
        log.info("register..." + vo);
        return mapper.insert(vo);
    }

    @Override
    public ReplyVO get(Long rno) {
        log.info("get..." + rno);
        return mapper.read(rno);
    }

    @Override
    public int modify(ReplyVO vo) {
        log.info("modify..." + vo);
        return mapper.update(vo);
    }

    @Override
    public int remove(Long rno) {
        log.info("remove..." + rno);
        return mapper.delete(rno);
    }

    @Override
    public List<ReplyVO> getList(Criteria criteria, Long bno) {
        log.info("get replies from a board..." + bno);
        return mapper.getListWithPaging(criteria, bno);
    }

    @Override
    public ReplyPageDTO getListPage(Criteria criteria, Long bno) {
        return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(criteria, bno));
    }
}
