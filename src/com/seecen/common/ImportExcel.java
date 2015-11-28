package com.seecen.common;

import java.io.File;

import jxl.Sheet;
import jxl.Workbook;

import com.opensymphony.xwork2.ActionSupport;

public class ImportExcel extends ActionSupport {
	private File file;
	private String fileContentType;
	private String fileFileName;

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	@Override
	public String execute() throws Exception {
		Workbook book = Workbook.getWorkbook(file);
		Sheet sheet = book.getSheet(0);
		for (int i = 0; i < sheet.getRows(); i++) {
			for (int j = 0; j < sheet.getColumns(); j++) {
				System.out.print(sheet.getCell(j, i).getContents() + "\t");
			}
			System.out.println();
		}
		return SUCCESS;
	}

}
