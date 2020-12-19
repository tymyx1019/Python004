from django.shortcuts import render, redirect
from .form import LoginForm
from django.contrib.auth import authenticate, login, decorators, logout
from django.http import HttpResponse


@decorators.login_required()
def index(request):
    return render(request, 'index.html')


def user_login(request):
    # 登录状态下跳转到index
    if request.user.is_authenticated:
        return redirect('/index/index')

    if request.method == 'POST':
        login_form = LoginForm(request.POST)
        if login_form.is_valid():
            cd = login_form.cleaned_data
            user = authenticate(
                username=cd['username'],
                password=cd['password'])
            if user:
                login(request, user)
                return redirect('/index/index')
            else:
                return HttpResponse('登录失败')
        else:
            return HttpResponse('参数错误')
    else:
        login_form = LoginForm()

    return render(request, 'login.html', {'form': login_form})


def user_logout(request):
    # 退出登录
    logout(request)
    return redirect('/index/login')
