package com.arch.util;


import org.apache.commons.pool2.impl.GenericObjectPoolConfig;
import org.apache.log4j.Logger;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

public class RedisUtil {


    protected static Logger logger = Logger.getLogger(RedisUtil.class);



	  private static JedisPool jedisPool = null;

	  
	    public static void returnResource(final Jedis jedis) {
	        if (jedis != null && jedisPool !=null) {
	    		
	    			jedis.close();
	    		
	        }
	    }
	    private static synchronized void poolInit() {
	        if (jedisPool == null) {  
	            initialPool();
	        }
	    }
	    public synchronized static Jedis getJedis() {  
	        if (jedisPool == null) {  
	            poolInit();
	        }
	        Jedis jedis = null;
	        try {  
	            if (jedisPool != null) {  
	                jedis = jedisPool.getResource(); 
	            }
	        } catch (Exception e) {  
	            logger.error("Get jedis error : "+e);
	        }finally{
	           
	        }
	        return jedis;
	    }  


	    private static void initialPool(){
	        try {
	            JedisPoolConfig config = new JedisPoolConfig();
	            config.setMaxTotal(1000);
	            config.setMaxIdle(100);
	            config.setMaxWaitMillis(3000);
	            config.setTestOnBorrow(true);
	            config.setBlockWhenExhausted(false);    
	            jedisPool = new JedisPool(config, "127.0.0.1", 6379, 2000);
	        } catch (Exception e) {


	               System.out.print("初始化jedis连接池错误！");

	        }
	    }
	
	    public static void setString(String key ,String value){
	    	Jedis jedis=null;
	        try {
	            value = isEmpty(value) ? "" : value;
	             jedis = getJedis();
	            jedis.set(key,value);
	        } catch (Exception e) {
	            logger.error("Set key error : "+e);
	        }finally{
	        returnResource(jedis);
	        }
	    }
	    public static void setString(String key ,int seconds,String value){
	    	Jedis jedis=null;
	        try {
	            value = isEmpty(value) ? "" : value;
	            jedis=getJedis();
	            jedis.setex(key, seconds, value);
	        } catch (Exception e) {
	            logger.error("Set keyex error : "+e);
	        }finally{
		        returnResource(jedis);
		        }
	    }
	     
	    /**
	     * 获取String值
	     * @param key
	     * @return value
	     */
	    public static String getString(String key){
	    	Jedis jedis=null;
	        String res="";
	    	try{
	    		jedis=getJedis();

	        if(jedis == null || !jedis.exists(key)){
	            return null;
	        }
	        res= jedis.get(key);
	        } catch (Exception e) {
	            logger.error("get keyex error : "+e);
	        }
	        finally{
		        returnResource(jedis);
		        }
	    	return res;
	        
	    }
	    public static boolean isEmpty(Object str) {
	        return ("").equals(str) || str == null;
	    }
	}

