package com.arch.webcontroller;

public class ArrayTime{

	private long[] time;
	private int length = 10; //默认为十次（10s内刷新10次则违反规则） 
	public ArrayTime(){
	}

	public void init(){
	time = new long[length];
	}

	public int getLength(){
	return this.length;
	}

	public void setLength(int len)
	 {
	this.length = len;
	}

	public long getLast(){
	return this.time[length-1];
	}

	public long getFirst(){
	return this.time[0];
	}

	public long getElement(int i){
	return time[i];
	}

	public void insert(long nextTime){
	if (this.getLast() != 0)//数组已经满了 
	{
	//去掉首元素，将数组元素顺序前移，nextTime插到最后 
	for(int i = 0 ;i < this.length-1;i++){
	time[i] = time[i+1];
	}
	this.time[length-1] = nextTime;
	} else{
	//插到下一个，不用排序 
	int j=0;
	while(time[j] != 0){
	j++;
	}
	time[j] = nextTime;
	}
	}
	}

