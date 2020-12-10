package com.tour.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.tour.dto.BoardDTO;
import com.tour.service.BoardService;

@Controller
@RequestMapping(value="/board")
public class BoardController {
	private static final Logger log = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	BoardService service;
	
	@GetMapping(value="/list")
	public void list(Model model) {
		service.getList(model);
	}
	
	@GetMapping(value="/register")
	public void register() {}
	
	@PostMapping(value="/register")
	@ResponseBody
	public int register(BoardDTO dto) {
		int result = service.register(dto);
		log.info(dto.toString());
		return result;
	}
	
	@PostMapping(value="/fileUpload")
	public void fileUpload(MultipartFile[] uploadFile) {
		for(MultipartFile file : uploadFile) {
			log.info(file.getOriginalFilename());
			log.info("size : "+file.getSize());
		}
	}
	
	@GetMapping(value="/detail")
	public String detail(@RequestParam("id") int id, Model model, HttpServletResponse response,HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		Cookie hitCookie = null;
		
		if(cookies != null && cookies.length > 0) {
			for (Cookie cookie : cookies) {
				String cName = cookie.getName();
				String cValue = cookie.getValue();
				log.info(cookie.getName() + " : " + cookie.getValue());
				if(cName.equals("upHit") && cValue.equals("userId"+id)) {
					hitCookie = cookie;
					log.info("이미 존재하는 쿠키");
				}
			}
		}
		
		if(hitCookie == null) {
			service.upHit(id);
			hitCookie = new Cookie("upHit", "userId"+id);
			response.addCookie(hitCookie);
		}
		
		service.getDetail(model, id);
		return "/board/detail";
	}
	
	@GetMapping(value="recommend")
	public String upRecommend(@RequestParam("id") int id, HttpServletRequest request, HttpServletResponse response) {
		Cookie[] cookies = request.getCookies();
		Cookie recoCookie = null;
		if(cookies != null && cookies.length > 0) {
			for(Cookie cookie : cookies) {
				String cName = cookie.getName();
				String cValue = cookie.getValue();
				if(cName.equals("recommend") && cValue.equals("userId"+id)) {
					recoCookie = cookie;
					log.info("이미 존재하는 쿠키");
				}
			}
		}
		
		if(recoCookie == null) {
			recoCookie = new Cookie("recommend", "userId"+id);
			response.addCookie(recoCookie);
			service.upRecommend(id);
		}
		return "redirect:/board/detail?id="+id;
	}
	
	@GetMapping(value="/delete")
	public String delete(@Param("ref") int ref) {
		int result = service.delete(ref);
		return "redirect:/board/list";
	}
	
	@GetMapping(value="/modify")
	public void modify(Model model, @Param("id") int id){
		service.getDetail(model, id);
	}
	
	@PostMapping(value="/modify")
	public String modify(BoardDTO dto) {
		log.info("dto : "+dto.toString());
		service.modify(dto);
		return "redirect:/board/list";
	}
	
	@PostMapping(value="/reply")
	public String reply(BoardDTO dto) {
		service.reply(dto);
		return "redirect:/board/detail?id="+dto.getId();
	}
}
