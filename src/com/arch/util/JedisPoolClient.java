package com.arch.util;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;
 
public class JedisPoolClient {
 
	private static JedisPool pool = null;
	/**
	 * 
	 * 方法描述 构建redis连接池
	 *
	 * @return
	 * 
	 * @author yaomy
	 * @date 2018年1月11日 下午4:53:07
	 */
	static {
		if(pool == null) {
			JedisPoolConfig config = new JedisPoolConfig();
			//控制一个pool可分配多少个jedis实例，通过pool.getResource()来获取；
            //如果赋值为-1，则表示不限制；如果pool已经分配了maxActive个jedis实例，则此时pool的状态为exhausted(耗尽)。
			config.setMaxTotal(50);
			//控制一个pool最多有多少个状态为idle(空闲的)的jedis实例。
			config.setMaxIdle(5);
			//表示当borrow(引入)一个jedis实例时，最大的等待时间，如果超过等待时间，则直接抛出JedisConnectionException；单位毫秒
			//小于零:阻塞不确定的时间,  默认-1
			config.setMaxWaitMillis(1000*100);
			//在borrow(引入)一个jedis实例时，是否提前进行validate操作；如果为true，则得到的jedis实例均是可用的；
			config.setTestOnBorrow(true);
			//return 一个jedis实例给pool时，是否检查连接可用性（ping()）
			config.setTestOnReturn(true);
			config.setTestWhileIdle(true);
			config.setTimeBetweenEvictionRunsMillis(30000);
			config.setNumTestsPerEvictionRun(5);
			config.setMinEvictableIdleTimeMillis(60000);
			//connectionTimeout 连接超时（默认2000ms）
			//soTimeout 响应超时（默认2000ms）
			pool = new JedisPool(config, "localhost", 6379,  2000);
		}
	}
	/**
	 * 
	 * 方法描述 获取Jedis实例
	 *
	 * @return
	 * 
	 * @author yaomy
	 * @date 2018年1月11日 下午4:56:58
	 */
	public static synchronized Jedis getJedis() {

		return pool.getResource();
	}
	/**
	 * 
	 * 方法描述 释放jedis连接资源
	 *
	 * @param jedis
	 * 
	 * @author yaomy
	 * @date 2018年1月12日 上午10:36:07
	 */
	public static synchronized void returnResource(Jedis jedis) {
		if(jedis != null) {
			jedis.close();
		}
	}
}
