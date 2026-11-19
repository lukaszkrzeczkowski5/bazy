create table pracownik(
 id_pracownika int auto_increment primary key,
imie varchar(40) not null,
nazwisko varchar(60) not null,
data_urodzenia date not null 
);

insert into pracownik (imie, nazwisko, data_urodzenia) values
('Jan', 'Kowalski', '2000-01-01'),
('Franek', 'Nowak', '2000-02-02'),
('Bartek', 'Kopak', '2000-03-03');

update pracownik set data_urodzenia = '2000-04-04' where id_pracownika=1;

select * from pracownik;
select * from zadanie;

create table zadanie (
id_zadania int auto_increment primary key,
nazwa_zadania varchar(150) not null,
priorytet enum('niski','normalny','wysoki'),
opis longtext,
pracownik int, 
foreign key(pracownik) references pracownik(id_pracownika) on delete set null
);

alter table zadanie modify priorytet enum('niski','normalny','wysoki') default 'normalny';

insert into zadanie (nazwa_zadania, priorytet , opis, pracownik) values
('przygotowanie raportu', 'wysoki', 'musisz zrobic bo wazne', 2),
('zaktualizowac dokumentację', 'niski', null, 1),
('przetestowac aplikację', default, 'testy apliacji', 3 );


create table projekt (
id_projektu int auto_increment primary key,
nazwa_projektu varchar(150),
data_rozpoczecia date not null,
data_zakonczenia date
);

alter table projekt add menadzer_projektu int,
add constraint foreign key(menadzer_projektu) references pracownik(id_pracownika) ;
;

insert into projekt (nazwa_projektu, data_rozpoczecia, data_zakonczenia, menadzer_projektu) values
('projekt 1', '2000-05-05', null, 2),
('projekt 2', '2000-06-06', '2001-04-20', 3);

select * from projekt;

alter table zadanie add column projekt int,
add foreign key (projekt) references projekt(id_projektu) on delete cascade;

update zadanie set projekt = 1 where id_zadania in (2,3);

create table sprint (
id_sprintu int primary key auto_increment,
numer_sprintu int unsigned,
data_rozpoczecia date,
data_zakonczenia date
);
insert into sprint (numer_sprintu, data_rozpoczecia, data_zakonczenia) values
(1, '2000-01-01', '2000-01-05');
update zadanie set sprint = 1 where id_zadania in (2,3);

alter table zadanie add column sprint int, add foreign key (sprint) references sprint(id_sprintu) on delete set Null;

create table status (
id_statusu int auto_increment primary key,
nazwa_statusu varchar(20)
);
insert into status (nazwa_statusu) values
('status 1'),
('status 2'),
('status 3');
select * from status;

create table zadanie_has_status (
id_zdarzenia int auto_increment primary key,
id_zadania int, foreign key(id_zadania) references zadanie(id_zadania) on delete set null,
id_statusu int, foreign key(id_statusu) references status(id_statusu) on delete set null,
data_zdarzenia datetime default current_timestamp
);
insert into zadanie_has_status (id_zadania, id_statusu) values
(1,1),
(2,2),
(3,3);
update zadanie_has_status set id_zdarzenia = 3 where id_zdarzenia = 6;
select * from zadanie_has_status;
delete from projekt where id_projektu =1;
alter table zadanie drop foreign key zadanie_ibfk_3;
drop table sprint;

-- lab04 --
-- zadanie 1 --
alter table zadanie drop foreign key zadanie_ibfk_1;
alter table projekt drop foreign key projekt_ibfk_1;

alter table pracownik modify id_pracownika int not null;
alter table pracownik drop primary key;

alter table pracownik modify id_pracownika int not null auto_increment;

alter table zadanie 
	add constraint fk_zadanie_pracownik
		foreign key (pracownik) references pracownik(id_pracownika)
        on delete set null;
alter table projekt 
	add constraint fk_menadzer_projektu
		foreign key (menadzer_projektu) references pracownik(id_pracownika);

-- zadanie 2 --
alter table zadanie add column godziny_szacowanie integer default 8;

update zadanie set godziny_szacowane = 4 where id_zadania=1;

alter table zadanie alter column godziny_szacowane set default 6;

insert into zadanie (nazwa_zadania) values
('zadanie 2');
 select * from zadanie;
delete from zadanie where id_zadania=4;

-- zadanie 3 --
alter table projekt
add column  opis_kratki varchar(50);

alter table projekt  modify opis_kratki varchar(200);
select * from projekt;
update projekt set opis_kratki = 'MVP' where id_projektu = 2;

alter table projekt drop column opis_kratki;

-- zadanie 4 -- 

alter table zadanie drop foreign key zadanie_ibfk_2;

alter table zadanie 
	add constraint fk_zadanie_projekt
		foreign key (projekt) references projekt(id_projektu)
        on delete set null;

delete from projekt where id_projektu=2;
select * from zadanie;
 









