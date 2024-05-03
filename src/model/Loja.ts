import { Table, Column, Model, ForeignKey } from 'sequelize-typescript';
import { endereco } from './Endereco';

@Table
export class loja extends Model {
  @Column({ primaryKey: true, autoIncrement: true })
  id_Loja: number;

  @ForeignKey(() => endereco)
  @Column
  fk_Endereco: number;

  @Column
  cnpj: string;

  @Column
  nome_fantasia: string;

  @Column
  numero_whatsapp: string;

  @Column
  numero_telefone: string;

  @Column
  email: string;

  @Column
  vlr_min_entrega: number;

  @Column({ type: 'bytea' })
  logo: Buffer; // Supondo que você irá armazenar a logo em formato de Buffer
}
