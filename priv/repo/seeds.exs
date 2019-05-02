# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tphx.Repo.insert!(%Tphx.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Tphx.Repo
alias Tphx.Accounts.Role
alias Tphx.Accounts.User
alias Tphx.Products.Product


users = [
  %{username: "admin", password: "4321", password_confirmation: "4321", role: "Admin", admin: true},
  %{username: "user1", password: "1234", password_confirmation: "1234", role: "User", admin: false},
  %{username: "user2", password: "1234", password_confirmation: "1234", role: "User", admin: false},
  %{username: "user3", password: "1234", password_confirmation: "1234", role: "User", admin: false}
]

for user <- users do
  email = user.username <> "@example.com"


  repo_role = Repo.get_by(Role, name: user.role) ||
              Repo.insert!(%Role{name: user.role, admin: user.admin})

  Repo.get_by(User, email: email) ||
  Ecto.build_assoc(repo_role, :users, %{username: user.username, 
                        email: email, 
                        password_digest: Bcrypt.hash_pwd_salt(user.password),
                        #password: Bcrypt.hash_pwd_salt(user.password),
                        #password_confirmation: Bcrypt.hash_pwd_salt(user.password_confirmation), 
                        role_id: repo_role.id})
  |>Repo.insert!()
end

products = [
  %{title: "Title 1",  price: Enum.random(1..1_000)},
  %{title: "Title 2",  price: Enum.random(1..1_000)},
  %{title: "Title 3",  price: Enum.random(1..1_000)},
  %{title: "Title 4",  price: Enum.random(1..1_000)},
  %{title: "Title 5",  price: Enum.random(1..1_000)},
  %{title: "Title 6",  price: Enum.random(1..1_000)},
  %{title: "Title 7",  price: Enum.random(1..1_000)},
  %{title: "Title 8",  price: Enum.random(1..1_000)},
  %{title: "Title 9",  price: Enum.random(1..1_000)},
  %{title: "Title 10", price: Enum.random(1..1_000)}
]

#IO.puts(products)

for prod <- products do
description = "Same description for " <> prod.title
slug = String.reverse(String.replace(String.downcase(prod.title)," ", "_"))<>"_"<>String.replace(String.downcase(prod.title)," ", "_")
  #TitleNumber = Integer.to_string(Enum.random(1..50))
IO.puts(prod.title)
IO.puts(slug)
IO.puts(prod.price)
IO.puts(description)



Repo.get_by(Product, slug: slug) ||
Repo.insert!(%Product{title: prod.title, 
                      slug: slug,
                      price: prod.price,
                      description: description})
#  IO.puts(prod)  
#  IO.puts(description)                                     
end

"""
defmodule ProductSeed do
def countup(limit) do
  countup(1, limit)
end

defp countup(count, limit) when count <= limit do
  TitleNumber =  Integer.to_string(Enum.random(1..limit)*Enum.random(limit))
  product = Repo.get(Products) |> last() |> Repo.one()

  repo_product = Repo.get_by(Products, slug: product.slug) ||
  Repo.insert!(%Product{title: "Title "<> TitleNumber, 
                        slug: "Title "<>TitleNumber, 
                        price: Enum.random(1..1_000), 
                        description: "Same description for "<>"Title "<>Integer.to_string(count)})
  countup(count + 1, limit)
end

ProductSeed.countup(10)
end
"""