# admin_generator_rails

So, the general idea here is to build a whole admin backend in one shot based off of your schema.

If you take a legacy database dump, load it locally on your system, and point your ```database.yml``` file at it, you can run ```rake db:schema:dump``` and it'll generate it for you.

I personally hate active_admin with a passion, and I think template generation is the way to go if you want to be able to customize stuff later.
