from django.urls import path,include
from.import views

app_name='tour'
urlpatterns = [
    path('tour/', views.tour, name='tour'),
    path('tlist/', views.tlist, name='tlist'),
    path('tplace/', views.tplace, name='tplace'),
    path('tstay/', views.tstay, name='tstay'),
    path('tfood/', views.tfood, name='tfood'),
    
    path('ajax_date/', views.ajax_date, name='ajax_date'),

]