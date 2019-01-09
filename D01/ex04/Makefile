NAME=ex04

CC=swiftc

SRCS=Color.swift Value.swift Card.swift Deck.swift main.swift

all: $(NAME)

$(NAME):
	$(CC) -o $(NAME) $(SRCS)

fclean: 
	@rm -rfv $(NAME)

re: fclean all