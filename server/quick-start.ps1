# 快速启动脚本
# 如果Maven未安装，请先安装Maven或使用IDE运行

Write-Host "检查Maven安装..." -ForegroundColor Yellow

# 检查Maven是否可用
try {
    $mvnVersion = mvn -version 2>&1
    Write-Host "Maven已安装" -ForegroundColor Green
    Write-Host $mvnVersion
    
    Write-Host "`n开始编译项目..." -ForegroundColor Yellow
    mvn clean install
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "`n编译成功！启动应用..." -ForegroundColor Green
        mvn spring-boot:run
    } else {
        Write-Host "`n编译失败，请检查错误信息" -ForegroundColor Red
    }
} catch {
    Write-Host "`nMaven未安装或未配置到PATH" -ForegroundColor Red
    Write-Host "请选择以下方案之一：" -ForegroundColor Yellow
    Write-Host "1. 安装Maven并配置PATH（参考 启动说明.md）" -ForegroundColor Cyan
    Write-Host "2. 使用IDE（IntelliJ IDEA/Eclipse）直接运行 BlogApplication.java" -ForegroundColor Cyan
    Write-Host "3. 如果已安装但未配置PATH，请手动配置环境变量" -ForegroundColor Cyan
}
