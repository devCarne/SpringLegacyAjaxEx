package stu.kms.controller;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import oracle.jdbc.proxy.annotation.Post;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import stu.kms.domain.BoardVO;
import stu.kms.domain.Criteria;
import stu.kms.service.BoardService;

@Controller
@AllArgsConstructor
@Log4j
@RequestMapping("/board/*")
public class BoardController {

    private BoardService service;

    @GetMapping("/list")
    public void list(Criteria criteria, Model model) {
        log.info("list : " + criteria);
        model.addAttribute("list", service.getList(criteria));
    }

    @GetMapping("/register")
    public void register() {

    }

    @PostMapping("/register")
    public String register(BoardVO board, RedirectAttributes redirectAttributes) {
        log.info("register : " + board);
        service.register(board);
        redirectAttributes.addFlashAttribute("result", board.getBno());
        return "redirect:/board/list";
    }

    @GetMapping({"/get", "/modify"})
    public void get(@RequestParam("bno") Long bno, Model model) {
        log.info("/get or modify");
        model.addAttribute("board", service.get(bno));
    }

    @PostMapping("/modify")
    public String modify(BoardVO board, RedirectAttributes redirectAttributes) {
        log.info("modify : " + board);
        if (service.modify(board)) {
            redirectAttributes.addFlashAttribute("result", "success");
        }

        return "redirect:/board/list";
    }

    @PostMapping("/remove")
    public String remove(@RequestParam("bno") Long bno, RedirectAttributes redirectAttributes) {
        log.info("remove " + bno);

        if (service.remove(bno)) {
            redirectAttributes.addFlashAttribute("result", "success");
        }

        return "redirect:/board/list";
    }
}
