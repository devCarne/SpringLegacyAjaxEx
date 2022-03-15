package stu.kms.mapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import stu.kms.domain.BoardVO;
import stu.kms.domain.Criteria;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTest {

    @Setter (onMethod_ = {@Autowired})
    private BoardMapper boardMapper;

    @Test
    public void testGetList() {
        boardMapper.getList().forEach(log::info);
    }

    @Test
    public void testInsert() {
        BoardVO board = new BoardVO();
        board.setTitle("새로 작성하는 글");
        board.setContent("새로 작성하는 내용");
        board.setWriter("newbie");

        boardMapper.insert(board);
        log.info(board);
    }

    @Test
    public void testInsertSelectKey() {
        BoardVO board = new BoardVO();
        board.setTitle("새로 작성하는 글 select key");
        board.setContent("새로 작성하는 내용 select key");
        board.setWriter("newbie");

        boardMapper.insertSelectKey(board);
        log.info(board);
    }

    @Test
    public void testRead() {
        log.info(boardMapper.read(5L));
    }

    @Test
    public void testDelete() {
        log.info(boardMapper.delete(3L));
    }

    @Test
    public void testUpdate() {
        BoardVO board = new BoardVO();
        board.setBno(5L);
        board.setTitle("수정된 제목");
        board.setContent("수정된 내용");
        board.setWriter("user00");

        log.info("UPDATE count : " + boardMapper.update(board));
    }

    @Test
    public void testPaging() {
        Criteria criteria = new Criteria();
        criteria.setPageNum(3);
        criteria.setAmount(10);

        List<BoardVO> list = boardMapper.getListWithPaging(criteria);
        list.forEach(log::info);
    }
}
