from django.shortcuts import render
from django.http import HttpResponse
from django.core.paginator import Paginator

from .models import Comments


# Create your views here.

def index(request):
    data_list = Comments.objects.filter(rating__gt=3)

    try:
        search_text = request.GET['search_text'].strip()
    except KeyError:
        search_text = ''

    contact_list= []
    if search_text:
        for row in data_list:
            # if search_text in row.comment_content :
            if row.comment_content.find(search_text) >= 0:
                contact_list.append(row)
    else:
        contact_list = data_list
        search_text = ''

    paginator = Paginator(contact_list, 20)

    page = request.GET.get('page')
    contacts = paginator.get_page(page)

    context = {'contacts': contacts, 'search_text':search_text}
    return render(request, 'index.html', context)
