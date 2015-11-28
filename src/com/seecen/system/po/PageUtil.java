package com.seecen.system.po;
public class PageUtil {
	private int currentPage;  // 当前页号
	private int pageSize;    // 每页 多少记录
	private int totalSize;  // 总记录数
	private int totalPage; // 总页数

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalSize() {
		return totalSize;
	}

	public void setTotalSize(int totalSize) {
		this.totalSize = totalSize;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalSize) {
		//通过传全部记录数计算，总的页数
		if(totalSize%this.pageSize==0){
			this.totalPage=totalSize/this.pageSize;
		}else{
			this.totalPage=totalSize/this.pageSize+1;
		}
		
	}

}
