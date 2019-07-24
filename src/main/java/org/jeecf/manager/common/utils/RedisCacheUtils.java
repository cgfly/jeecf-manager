package org.jeecf.manager.common.utils;

import java.util.HashSet;
import java.util.Set;

import org.apache.commons.collections.CollectionUtils;
import org.jeecf.common.enums.SplitCharEnum;
import org.jeecf.manager.config.RedisObjectSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;

import redis.clients.jedis.Jedis;

/**
 * redis 缓存工具
 * 
 * @author jianyiming
 *
 */
public class RedisCacheUtils {

    private static final String CACHE_PREFIX = "JEECF";

    private static final String[] CACHE_TYPE = {"SYS" };

    private static final int DEFAULT_TIMEOUT = 24 * 60 * 60;

    private static final StringRedisSerializer STRING_REDIS_SERIALIZER = new StringRedisSerializer();

    private static final RedisObjectSerializer REDIS_OBJECT_SERIALIZER = new RedisObjectSerializer();

    public static void setSysCache(String key, String value) {
        Jedis jedis = RedisUtils.getJedis();
        try {
            jedis.setex(STRING_REDIS_SERIALIZER.serialize(CACHE_PREFIX + SplitCharEnum.UNDERLINE.getName() + CACHE_TYPE[0] + SplitCharEnum.UNDERLINE.getName() + key), DEFAULT_TIMEOUT,
                    STRING_REDIS_SERIALIZER.serialize(value));
        } finally {
            jedis.close();
        }

    }

    public static String getSysCache(String key) {
        String result = null;
        Jedis jedis = RedisUtils.getJedis();
        try {
            byte[] bytes = jedis.get(STRING_REDIS_SERIALIZER.serialize(CACHE_PREFIX + SplitCharEnum.UNDERLINE.getName() + CACHE_TYPE[0] + SplitCharEnum.UNDERLINE.getName() + key));
            if (bytes != null) {
                result = STRING_REDIS_SERIALIZER.deserialize(bytes);
                jedis.expire(STRING_REDIS_SERIALIZER.serialize(CACHE_PREFIX + SplitCharEnum.UNDERLINE.getName() + CACHE_TYPE[0] + SplitCharEnum.UNDERLINE.getName() + key), DEFAULT_TIMEOUT);
            }
        } finally {
            jedis.close();
        }
        return result;
    }

    public static void setCache(String key, Object value) {
        Jedis jedis = RedisUtils.getJedis();
        try {
            jedis.set(STRING_REDIS_SERIALIZER.serialize(CACHE_PREFIX + SplitCharEnum.UNDERLINE.getName() + key), REDIS_OBJECT_SERIALIZER.serialize(value));
        } finally {
            jedis.close();
        }
    }

    public static void setCache(String key, Object value, int timeout) {
        Jedis jedis = RedisUtils.getJedis();
        try {
            jedis.setex(STRING_REDIS_SERIALIZER.serialize(CACHE_PREFIX + SplitCharEnum.UNDERLINE.getName() + key), timeout, REDIS_OBJECT_SERIALIZER.serialize(value));
        } finally {
            jedis.close();
        }
    }

    public static Object getCache(String key) {
        Jedis jedis = RedisUtils.getJedis();
        try {
            byte[] bytes = jedis.get(STRING_REDIS_SERIALIZER.serialize(CACHE_PREFIX + SplitCharEnum.UNDERLINE.getName() + key));
            if (bytes != null) {
                return REDIS_OBJECT_SERIALIZER.deserialize(bytes);
            }
        } finally {
            jedis.close();
        }
        return null;
    }

    public static void delCache(String key) {
        Jedis jedis = RedisUtils.getJedis();
        try {
            jedis.del(STRING_REDIS_SERIALIZER.serialize(CACHE_PREFIX + SplitCharEnum.UNDERLINE.getName() + key));
        } finally {
            jedis.close();
        }
    }

    public static void delCache(Set<String> keys) {
        Jedis jedis = RedisUtils.getJedis();
        try {
            if (CollectionUtils.isNotEmpty(keys)) {
                for (String key : keys) {
                    jedis.del(STRING_REDIS_SERIALIZER.serialize(CACHE_PREFIX + SplitCharEnum.UNDERLINE.getName() + key));
                }
            }
        } finally {
            jedis.close();
        }
    }

    public static void expire(String key, int timeout) {
        Jedis jedis = RedisUtils.getJedis();
        try {
            jedis.expire(STRING_REDIS_SERIALIZER.serialize(CACHE_PREFIX + SplitCharEnum.UNDERLINE.getName() + key), timeout);
        } finally {
            jedis.close();
        }
    }

    public static Set<String> keys(String match) {
        Jedis jedis = RedisUtils.getJedis();
        Set<String> arraySet = new HashSet<String>();
        try {
            Set<byte[]> keys = jedis.keys(STRING_REDIS_SERIALIZER.serialize(CACHE_PREFIX + SplitCharEnum.UNDERLINE.getName() + match));
            if (CollectionUtils.isNotEmpty(keys)) {
                keys.forEach(key -> {
                    String redisKey = STRING_REDIS_SERIALIZER.deserialize(key);
                    arraySet.add(redisKey.split(CACHE_PREFIX + SplitCharEnum.UNDERLINE.getName())[1]);
                });
            }
        } finally {
            jedis.close();
        }
        return arraySet;
    }

}
