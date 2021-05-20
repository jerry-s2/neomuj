package com.neomuj.service;

import com.neomuj.dto.EmailDTO;

public interface EmailService {

	public void sendMail(EmailDTO dto, String message);
}
