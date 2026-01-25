-- 修复admin账号的role为ADMIN
-- 如果admin账号不存在，这个脚本不会创建它，需要重启应用让MockDataGenerator创建

UPDATE users 
SET role = 'ADMIN' 
WHERE account = 'admin';

-- 验证更新结果
SELECT id, account, username, role FROM users WHERE account = 'admin';
