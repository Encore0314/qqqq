package com.arch.webcontroller;

public class Visitor {

	/**//* Creates a new instance of Visitor
	*外网访问者，以sessionID作为标识
	*违反访问规则将其IP列为受限IP，拒绝访问
	*/
	private String sessionID = null;
	private ArrayTime requestTimeQueue= new ArrayTime();

	public Visitor() {
	}

	public void setSessionID(String sessionID)
	{
	this.sessionID = sessionID;
	}

	public String getSessionID()
	{
	return this.sessionID;
	}

	public void setRequestTimeQueue(ArrayTime requestTimeQueue)
	{
	this.requestTimeQueue = requestTimeQueue;
	}

	public ArrayTime getRequestTimeQueue()
	{
	return this.requestTimeQueue;
	}
	}
