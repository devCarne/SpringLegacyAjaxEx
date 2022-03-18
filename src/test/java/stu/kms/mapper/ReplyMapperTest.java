package stu.kms.mapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import stu.kms.domain.Criteria;
import stu.kms.domain.ReplyVO;

import java.util.List;
import java.util.stream.IntStream;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTest {

    private Long[] bnoArr = {2297L, 2296L, 2294L, 2293L, 2292L};

    @Setter(onMethod_ = @Autowired)
    private ReplyMapper mapper;

    @Test
    public void testMapper() {
        log.info(mapper);
    }

    @Test
    public void testCreate() {
        IntStream.rangeClosed(1, 10).forEach(i -> {
            ReplyVO vo = new ReplyVO();
            vo.setBno(bnoArr[i % 5]);
            vo.setReply("댓글 테스트" + i);
            vo.setReplyer("replyer" + i);

            mapper.insert(vo);
        });
    }

    @Test
    public void testRead() {
        log.info(mapper.read(5L));
    }

    @Test
    public void testDelete() {
        log.info(mapper.delete(3L));
    }

    @Test
    public void testUpdate() {
        ReplyVO vo = mapper.read(12L);
        vo.setReply("변경된 댓글");
        log.info(mapper.update(vo));
    }

    @Test
    public void testList() {
        Criteria criteria = new Criteria();
        List<ReplyVO> replies = mapper.getListWithPaging(criteria, bnoArr[0]);
        replies.forEach(log::info);
    }

    @Test
    public void testList2() {
        Criteria cri = new Criteria(2, 3);
        List<ReplyVO> replies = mapper.getListWithPaging(cri, 2297L);
        replies.forEach(log::info);
    }
}
