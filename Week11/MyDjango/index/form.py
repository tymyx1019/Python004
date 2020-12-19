from django.forms import Form
from django.forms import widgets
from django.forms import fields


class LoginForm(Form):
    username = fields.CharField(
        widget=widgets.TextInput(
            attrs={
                'class': 'form-control',
                'placeholder': '用户名'}))

    password = fields.CharField(
        widget=widgets.PasswordInput(
            attrs={
                'class': 'form-control',
                'placeholder': '密码'}),
        min_length=8)

    cc_myself = fields.BooleanField(required=False)
