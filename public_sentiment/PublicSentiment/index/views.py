from django.shortcuts import render
from django.http import HttpResponse
from .models import Phones
from .models import PhoneComments
from django.db.models import Avg, Sum, Max, Min, Count
import datetime


def index(request):
    '''
    手机首页列表
    :param request: 
    :return: 
    '''
    kwd_search = ' AND 1=1'

    begin_date = request.GET.get('begin_date', 0)
    end_date = request.GET.get('end_date',
                               datetime.datetime.now().strftime('%Y-%m-%d'))

    keyword = request.GET.get('keyword', None)
    if keyword:
        kwd_search = '%{}%'.format(keyword)
        sql = """
            SELECT AVG(pc.`mark`) AS avg_mark, phones.* FROM `phone_comments` AS pc
            LEFT JOIN `phones` ON pc.`sid`=phones.`sid`
            WHERE public_date>=%s AND public_date<=%s AND title LIKE %s
            GROUP BY pc.sid
        """
        comment_list = Phones.objects.raw(sql, [str(begin_date).replace(
            '-', ''), str(end_date).replace('-', ''), kwd_search])
    else:
        sql = """
            SELECT AVG(pc.`mark`) AS avg_mark, phones.* FROM `phone_comments` AS pc
            LEFT JOIN `phones` ON pc.`sid`=phones.`sid`
            WHERE public_date>=%s AND public_date<=%s
            GROUP BY pc.sid
        """
        comment_list = Phones.objects.raw(
            sql, [str(begin_date).replace('-', ''), str(end_date).replace('-', '')])

    return render(request, 'index.html', locals())


def comments(request):
    '''
    评论列表
    :param request: 
    :return: 
    '''
    sid = request.GET.get('sid', '')
    comments = PhoneComments.objects.filter(sid=sid)

    phone_object = Phones.objects.filter(sid=sid).first()

    avg_mark_object = PhoneComments.objects.filter(
        sid=sid).aggregate(Avg('mark'))

    return render(request, 'comments.html', locals())


def chart(request):
    '''
    图表分析
    :param request: 
    :return: 
    '''
    kwd_search = ' AND 1=1'

    begin_date = request.GET.get('begin_date', 0)
    end_date = request.GET.get('end_date',
                               datetime.datetime.now().strftime('%Y-%m-%d'))

    keyword = request.GET.get('keyword', None)
    if keyword:
        kwd_search = '%{}%'.format(keyword)
        sql = """
            SELECT AVG(pc.`mark`) AS avg_mark, phones.* FROM `phone_comments` AS pc
            LEFT JOIN `phones` ON pc.`sid`=phones.`sid`
            WHERE public_date>=%s AND public_date<=%s AND title LIKE %s
            GROUP BY pc.sid
        """
        comment_list = Phones.objects.raw(sql, [str(begin_date).replace(
            '-', ''), str(end_date).replace('-', ''), kwd_search])
    else:
        sql = """
            SELECT AVG(pc.`mark`) AS avg_mark, phones.* FROM `phone_comments` AS pc
            LEFT JOIN `phones` ON pc.`sid`=phones.`sid`
            WHERE public_date>=%s AND public_date<=%s
            GROUP BY pc.sid
        """
        comment_list = Phones.objects.raw(
            sql, [str(begin_date).replace('-', ''), str(end_date).replace('-', '')])

    return render(request, 'charts.html', locals())

    