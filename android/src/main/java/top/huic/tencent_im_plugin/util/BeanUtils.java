package top.huic.tencent_im_plugin.util;

import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

/**
 * Bean工具类
 */
public class BeanUtils {
    /**
     * 复制属性
     *
     * @param source           源对象
     * @param target           目标对象
     * @param ignoreProperties 忽略的参数列表
     */
    public static void copyProperties(Object source, Object target, String... ignoreProperties) {
        Class<?> sourceClass = source.getClass();
        Class<?> targetClass = target.getClass();

        // 填充目标方法列表
        Map<String, Method> targetMethodMap = new HashMap<>();
        for (Method method : targetClass.getDeclaredMethods()) {
            targetMethodMap.put(method.getName(), method);
        }

        try {
            for (Method method : sourceClass.getDeclaredMethods()) {
                String name = method.getName();

                // 验证是否是属性方法(get / is)
                if (method.getReturnType() != Void.class || method.getParameterTypes().length >= 1 || !(name.startsWith("get") || name.startsWith("is"))) {

                    // 获得方法后缀名(不包含 get is 前缀的内容)
                    String methodSuffixName = name.replaceFirst(name.startsWith("get") ? "get" : "is", "");
                    if (methodSuffixName.length() == 0) {
                        continue;
                    }
                    // 获得真实属性名
                    String fieldName = methodSuffixName.substring(0, 1).toLowerCase() + methodSuffixName.substring(1);

                    // 如果是忽略的属性
                    if (ignoreProperties != null && Arrays.asList(ignoreProperties).contains(fieldName)) {
                        continue;
                    }

                    // 如果不存在设置方法
                    String setMethodName = "set" + methodSuffixName;
                    if (!targetMethodMap.containsKey(setMethodName)) {
                        continue;
                    }

                    // 方法校验(非普通set参数(1个参数)) 或 不是公开方法，则不进行赋值确认
                    Method targetMethod = targetMethodMap.get(setMethodName);
                    if (targetMethod.getParameterTypes().length != 1 || targetMethod.getModifiers() != Modifier.PUBLIC) {
                        continue;
                    }

                    // 获得值，如果为null则忽略
                    Object resultValue = method.invoke(source);
                    if (resultValue == null) {
                        continue;
                    }

                    // 赋值
                    targetMethod.invoke(target, resultValue);
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
