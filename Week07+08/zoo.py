'''
背景：在使用 Python 进行《我是动物饲养员》这个游戏的开发过程中，有一个代码片段要求定义动物园、动物、猫、狗四个类。

这个类可以使用如下形式为动物园增加一只猫：

if __name__ == '__main__':
    # 实例化动物园
    z = Zoo('时间动物园')
    # 实例化一只猫，属性包括名字、类型、体型、性格
    cat1 = Cat('大花猫 1', '食肉', '小', '温顺')
    # 增加一只猫到动物园
    z.add_animal(cat1)
    # 动物园是否有猫这种动物
    have_cat = hasattr(z, 'Cat')

1.定义“动物”、“猫”、“狗”、“动物园”四个类，动物类不允许被实例化。

2.动物类要求定义“类型”、“体型”、“性格”、“是否属于凶猛动物”四个属性，
  是否属于凶猛动物的判断标准是：“体型 >= 中等”并且是“食肉类型”同时“性格凶猛”。

3.猫类要求有“叫声”、“是否适合作为宠物”以及“名字”三个属性，其中“叫声”作为类属性，
  除凶猛动物外都适合作为宠物，猫类继承自动物类。狗类属性与猫类相同，继承自动物类。

4.动物园类要求有“名字”属性和“添加动物”的方法，
  “添加动物”方法要实现同一只动物（同一个动物实例）不能被重复添加的功能。
'''
from abc import ABCMeta, abstractmethod


class Zoo(object):
    '''
    动物园类
    '''
    container = []

    def __init__(self, name=''):
        self.name = name

    def add_animal(self, animal):
        # 判断是否是动物，不是则raise一个错误
        if isinstance(animal, Animal):
            class_name = animal.__class__.__name__
            if not hasattr(self, class_name):
                setattr(self, class_name, animal)
                self.container.append(class_name)
        else:
            raise TypeError('必须添加动物对象')

    def __str__(self):
        '''
        打印动物园所有动物
        :return: 
        '''
        zoo_animals = []
        if len(self.container):
            for class_name in self.container:
                # zoo_animals = ', '.join(self.container)
                zoo_animals.append(getattr(self, class_name).name)

            return '{} 包含的动物有 {}'.format(self.name, ', '.join(zoo_animals))

        return ''


class Animal(metaclass=ABCMeta):
    '''
    动物类
    '''

    # 类型
    _eating_type = None

    # 体型
    _physique = None

    # 性格
    _character = None

    @abstractmethod
    def __init__(self, name, eating_type, physique, character):
        '''
        动物类初始化
        :param name: 名字
        :param eating_type: 进食类型，'食肉','食草','宠物粮'
        :param physique: 体型，'小','中','大'
        :param character: 性格，'温顺','凶猛'
        '''
        self.name = name
        self.eating_type = eating_type
        self.physique = physique
        self.character = character

    def is_terrible(self):
        return self._eating_type == '食肉' and self._physique in ('中', '大') and self._character == '凶猛'

    @property
    def eating_type(self):
        return self._eating_type

    @eating_type.setter
    def eating_type(self, value):
        type_list = ('食肉', '食草', '宠物粮')
        if value not in type_list:
            raise ValueError('进食类型必须为 {} 之一'.format(type_list))
        self._eating_type = value

    @property
    def physique(self):
        return self._physique

    @physique.setter
    def physique(self, value):
        physique_list = ('小', '中', '大')
        if value not in physique_list:
            raise ValueError('体型必须为 {} 之一'.format(physique_list))

    @property
    def character(self):
        return self._character

    @character.setter
    def character(self, value):
        character_list = ('温顺', '凶猛')
        if value not in character_list:
            raise ValueError('性格必须为 {} 之一'.format(character_list))

    @property
    def is_pets(self):
        '''
        是否适合做宠物
        :return: bool
        '''
        return not self.is_terrible()


class Cat(Animal):
    '''
    猫类
    '''

    # 叫声
    shouts = '喵喵喵'

    def __init__(self, name='猫', eating_type='食肉', physique='小', character='温顺'):
        super().__init__(name, eating_type, physique, character)
        self.name = name


class Dog(Animal):
    '''
    狗类
    '''

    # 叫声
    shouts = '汪汪汪'

    def __init__(self, name='汪星人', eating_type='宠物粮', physique='小', character='凶猛'):
        super().__init__(name, eating_type, physique, character)
        self.name = name


if __name__ == '__main__':
    try:
        # 实例化动物园
        z = Zoo('时间动物园')

        # 实例化一只猫，属性包括名字、类型、体型、性格
        cat = Cat('瞄星人', '食肉', '小', '温顺')

        # 实例化一只狗，属性包括名字、类型、体型、性格
        dog = Dog('旺星人', '食肉', '小', '温顺')

        # 增加一只猫到动物园
        z.add_animal(cat)

        # 增加一只猫到动物园
        z.add_animal(dog)

        # 动物园是否有猫这种动物
        have_cat = hasattr(z, 'Cat')
        print(have_cat)

        # 动物园的猫是否适合做宠物
        if have_cat and getattr(z, 'Cat').is_pets:
            print('动物园中的适合做宠物')

        # 打印动物园中所有的动物
        print(z)

    except Exception as e:
        print(e)