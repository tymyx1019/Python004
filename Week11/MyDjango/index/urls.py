from django.urls import path
from . import views


urlpatterns = [
    path('', views.index),
    path('index', views.index),
    path('logout', views.user_logout),
    path('login', views.user_login)
]
